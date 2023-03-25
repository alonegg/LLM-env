# 使用安装了pytorch的ubuntu镜像作为基础镜像
FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

# 设置工作目录
WORKDIR /app

# 安装git和conda
RUN apt-get update && apt-get install -y git wget && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# 将conda加入到环境变量
ENV PATH="/opt/conda/bin:$PATH"

# 克隆仓库
RUN git clone https://github.com/microsoft/visual-chatgpt.git

# 切换到仓库目录
WORKDIR /app/visual-chatgpt

# 创建新环境并激活
RUN conda create -y -n visgpt python=3.8 && \
    echo "source activate visgpt" > ~/.bashrc

# 激活新环境
RUN /bin/bash -c "source activate visgpt"

# 安装依赖
RUN pip install -r requirements.txt

# 设置环境变量
ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=${OPENAI_API_KEY}

# 运行命令
CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cuda:0,ImageEditing_cuda:0,Text2Image_cuda:1,Image2Canny_cpu,CannyText2Image_cuda:1"]
