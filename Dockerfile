FROM python:3.13@sha256:2d9f338cf7598aae8110f4eef1f3a6d2f8342d0c0b820879b2d79838edf6f565

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]