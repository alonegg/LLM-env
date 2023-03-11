FROM python:3.8-slim-buster

WORKDIR /app

COPY visual_chatgpt.py requirement.txt download.sh ./

RUN apt-get update && \
    apt-get install -y git && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirement.txt && \
    bash download.sh && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN mkdir /app/image && chmod 777 /app/image
