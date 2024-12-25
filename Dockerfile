FROM python:3.13@sha256:08371fabbdb8fd1c1256fa96492a27339bf60cba3cb26af7a2e5a56bc5060af4

WORKDIR /app

COPY requirements.txt requirements.txt
COPY install.sh install.sh

RUN chmod +x install.sh && ./install.sh

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]