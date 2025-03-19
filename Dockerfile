FROM python:3.13@sha256:8c55c44b9e81d537f8404d0000b7331863d134db87c1385dd0ec7fefff656495

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]