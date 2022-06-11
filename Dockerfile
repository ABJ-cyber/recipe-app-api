FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

ARG DEV=false
COPY ./requirements.txt /requirements.txt
COPY ./requirements.dev.txt /requirements.dev.txt

RUN apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev
RUN pip install -r /requirements.txt

RUN if [ $DEV = "true" ]; \
    then pip install -r /requirements.dev.txt ; \
fi

RUN apk del .tmp-build-deps
RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user

