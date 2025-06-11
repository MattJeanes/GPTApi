FROM python:3.13@sha256:eec1b4e88e8762b4711b9f5fd69648b96ac04864e56993769cf50a9891a1d317

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]