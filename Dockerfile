FROM python:3.12-slim-bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN pip install -r requirements.txt

RUN mkdir /app
COPY . /app/

WORKDIR /app

CMD ["gunicorn", "--bind", "0.0.0.0:80", "main:app"]
