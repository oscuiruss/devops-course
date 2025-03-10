#-----------------------------------------------------------------------------------
FROM alpine:3.21 AS builder

RUN apk add --no-cache openjdk17

WORKDIR /app

COPY spring-petclinic/build.gradle spring-petclinic/settings.gradle spring-petclinic/gradlew ./
COPY spring-petclinic/gradle gradle
COPY spring-petclinic/src ./src

RUN sed -i 's/\r$//' gradlew && \
    chmod +x gradlew && \
    ./gradlew dependencies --no-daemon --info

RUN ./gradlew clean build -x test --no-daemon

#------------------------------------------------------------------------------------
FROM alpine:3.21 AS production

RUN apk add --no-cache openjdk17

WORKDIR /app

COPY --from=builder /app/build/libs/spring-petclinic-*.jar ./libs/spring-petclinic.jar
COPY --from=builder /app/build/resources ./resources

RUN adduser -D -g 'nonroot' nonroot && chown -R nonroot:nonroot /usr/lib/jvm/java-17-openjdk /app/

USER nonroot

CMD ["java", "-jar", "/app/libs/spring-petclinic.jar"]
