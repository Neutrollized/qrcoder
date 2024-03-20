FROM python:3.11-slim-bookworm

ARG DEBIAN_FRONTEND=noninteractive

COPY requirements.txt . 
RUN pip install -r requirements.txt \
  && pip cache purge \
  && apt-get clean

RUN mkdir /app
WORKDIR /app

COPY src/ /app/

CMD ["gunicorn", "--bind", "0.0.0.0:80", "main:app"]
