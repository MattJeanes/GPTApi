FROM python:3.13@sha256:c33390eacee652aecb774f9606c263b4f76415bc83926a6777ede0f853c6bc19

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]