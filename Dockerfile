FROM python:3.13@sha256:589ed6659c0e4aac182f309131cd35e85452d21072570b1f6abc45b7687093a3

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]