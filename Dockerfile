FROM python:3.11-slim-bookworm

ARG DEBIAN_FRONTEND=noninteractive

COPY requirements.txt . 
RUN pip install -r requirements.txt \
  && pip cache purge \
  && apt-get clean

RUN mkdir /app
COPY src/ /app/

WORKDIR /app

CMD ["gunicorn", "--bind", "0.0.0.0:80", "main:app"]
