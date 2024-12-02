FROM ubuntu:20.04

RUN apt update && \
    apt install -yq software-properties-common curl && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt purge -yq software-properties-common && \
    apt install -yq python3.13 python3.13-distutils && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.13 get-pip.py && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt requirements.txt
RUN python3.13 -m pip install --no-cache-dir -r requirements.txt
RUN python3.13 -m pip install --no-cache-dir https://download.pytorch.org/whl/cpu/torch-1.9.1%2Bcpu-cp39-cp39-linux_x86_64.whl

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]