FROM python:3.13@sha256:d59d263333c08481fb66062240b3c34cdd8d215dcb3e9336a13e72cf034a184e

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]