FROM python:3.13@sha256:e95be020750503923c5d4f51a56ab8f5b21e40cdce66fb7000e270df68d04f8e

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]