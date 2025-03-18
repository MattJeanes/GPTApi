FROM python:3.13@sha256:a9710c44d58cb3fcba391e09b20e52147caf99be418aac2ba4ffa128435fc303

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]