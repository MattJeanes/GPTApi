FROM python:3.13@sha256:653b0cf8fc50366277a21657209ddd54edd125499d20f3520c6b277eb8c828d3

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]