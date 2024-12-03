FROM python:3.13@sha256:22723cfdc8ca2aba70201fb9b3d8ab66b33633b260aed95609d7f21a5eb6de33

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]