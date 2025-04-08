FROM python:3.13@sha256:aaf6d3c4576a462fb335f476bed251511f2f1e61ca8e8e97e9e197bc92a7a1ee

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]