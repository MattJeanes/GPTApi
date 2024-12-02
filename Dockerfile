FROM python:3.13@sha256:bc78d3c007f86dbb87d711b8b082d9d564b8025487e780d24ccb8581d83ef8b0

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]