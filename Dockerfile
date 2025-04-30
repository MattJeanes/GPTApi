FROM python:3.13@sha256:19c3e9658c3bab523c6ddb025464f3707cf3b1297100827bdb6afbf0c937d99f

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]