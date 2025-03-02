FROM python:3.12-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

WORKDIR /app

USER root
RUN pip install pipenv

USER appuser

COPY Pipfile Pipfile.lock /app/

RUN pipenv lock \
    && pipenv install --python /usr/local/bin/python3.12 --deploy \
    && find /usr/local/lib/python3.12/site-packages -name '*.pyc' -delete \
    && find /usr/local/lib/python3.12/site-packages -name '__pycache__' -delete

USER root
RUN rm -rf /root/.cache
USER appuser

COPY . /app
VOLUME ["/app/urlshort/static", "/app/urlshort/templates"]

CMD ["sh", "-c", "pipenv run flask db init && pipenv run flask db migrate && pipenv run flask db upgrade && exec pipenv run flask run --host=0.0.0.0"]
