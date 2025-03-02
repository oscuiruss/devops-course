###############
# Этап 1: Builder – сборка приложения с Maven на Alpine
###############
FROM maven:3.8.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app

# Копирование файла зависимостей для оптимизации кэширования (этап выполняется только при изменении pom.xml)
COPY pom.xml .

# Предзагрузка зависимостей (кэшируется, если pom.xml не изменился)
RUN mvn dependency:go-offline

# Копирование исходного кода
COPY src ./src

# Сборка приложения (тесты пропускаются для ускорения сборки)
RUN mvn package -DskipTests

# Очистка кеша менеджера пакетов для уменьшения размера образа
RUN rm -rf /var/cache/apk/*

###############
# Этап 2: Runtime – запуск приложения
###############
FROM eclipse-temurin:17-alpine
WORKDIR /app

# Создание непривилегированного пользователя
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Копирование собранного артефакта из builder-этапа
COPY --from=builder /app/target/*.jar app.jar

# Определение переменной окружения для порта (вся конфигурация через переменные)
ENV SERVER_PORT=8080
EXPOSE 8080

# Запуск приложения с использованием переменной окружения
ENTRYPOINT ["sh", "-c", "java -jar app.jar --server.port=${SERVER_PORT}"]
