FROM python:3.13@sha256:061dfa2a69c174a42781e083ce72e9a4570a07b9efead37c433a8ccad045d3bf

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]