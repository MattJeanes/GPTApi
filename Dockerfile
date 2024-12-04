FROM python:3.13@sha256:7861d60e586c47e7624286e4e78b086a936fb5284d47fe5e5c5068a9ddac6fb1

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]