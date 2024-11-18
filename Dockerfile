FROM python:3.13-alpine

RUN mkdir /app
WORKDIR /app

COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./

CMD ["gunicorn", "--bind", "0.0.0.0:80", "main:app"]
