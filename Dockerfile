FROM ubuntu:24.04@sha256:278628f08d4979fb9af9ead44277dbc9c92c2465922310916ad0c46ec9999295

RUN apt update && \
    apt install -yq software-properties-common curl && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt purge -yq software-properties-common && \
    apt install -yq python3.9 python3.9-distutils && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.9 get-pip.py && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt requirements.txt
RUN python3.9 -m pip install --no-cache-dir -r requirements.txt
RUN python3.9 -m pip install --no-cache-dir https://download.pytorch.org/whl/cpu/torch-1.9.1%2Bcpu-cp39-cp39-linux_x86_64.whl

COPY . .

EXPOSE 80
ENTRYPOINT [ "gunicorn", "app", "--timeout", "60", "--bind", "0.0.0.0:80" ]