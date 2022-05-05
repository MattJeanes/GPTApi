FROM ubuntu:20.04

RUN apt update && \
    apt install -yq software-properties-common curl && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install -yq python3.10 python3.10-distutils && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.10 get-pip.py && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN python3.10 -m pip install -r requirements.txt

WORKDIR /app
COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]