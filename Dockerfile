FROM python:3.13@sha256:c286f03b5b7ffbefa9c45b87c4d27f952b3706b180dc591cd983800d2e6a1fcb

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]