FROM python:3.13@sha256:7be9b757ea8fa90b43efd604dd5ef2923364230f00564b2ea7f0982d24b374c9

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]