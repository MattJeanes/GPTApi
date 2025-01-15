FROM python:3.13@sha256:a8aab6d8cce4d31c10dda046d6d940fc30b64de3438f7969f0db0ab19f3469f9

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]