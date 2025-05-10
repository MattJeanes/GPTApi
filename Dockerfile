FROM python:3.13@sha256:3abe339a3bc81ffabcecf9393445594124de6420b3cfddf248c52b1115218f04

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]