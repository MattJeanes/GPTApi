FROM python:3.13@sha256:ab70aee8e1bc6ffe4f95953ee2a98ca545123195a2b56d4338c7ea8ff5744a20

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]