FROM python:3.11-slim-bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /app
WORKDIR /app

COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt \
  && apt-get clean

COPY src/ ./

CMD ["gunicorn", "--bind", "0.0.0.0:80", "main:app"]
