FROM python:3.13@sha256:e3424acce37cdb1d7f885b2d13c14a550a0b6b96ff8a58d2a08883f3f865fd1e

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]