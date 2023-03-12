FROM python:3.8-slim-buster

WORKDIR /app

COPY visual_chatgpt.py requirement.txt download.sh ./

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
 
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN apt-get update && \
    apt-get install -y git && \
    pip install --no-cache-dir --upgrade pip && \
    conda install --no-cache-dir -r requirement.txt && \
    bash download.sh && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN mkdir /app/image && chmod 777 /app/image
