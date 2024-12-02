FROM python:3.13

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]