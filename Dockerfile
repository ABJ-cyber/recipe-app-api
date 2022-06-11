FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

ARG DEV=false
COPY ./requirements.txt /requirements.txt
COPY ./requirements.dev.txt /requirements.dev.txt
RUN pip install -r /requirements.txt

RUN if [ $DEV = "true" ]; \
    then pip install -r /requirements.dev.txt ; \
fi
RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user

