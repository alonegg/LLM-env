# 使用安装了pytorch的ubuntu镜像作为基础镜像
FROM nvcr.io/nvidia/pytorch:23.06-py3


# 设置工作目录
WORKDIR /workspace

# 安装git
RUN apt-get update && \
    apt-get install -y git

# 克隆仓库
RUN git clone https://github.com/ymcui/Chinese-LLaMA-Alpaca

# 切换到仓库目录
WORKDIR /workspace/Chinese-LLaMA-Alpaca

# 安装依赖
RUN pip install -r requirements.txt

# 设置环境变量
# ARG OPENAI_API_KEY
# ENV OPENAI_API_KEY=${OPENAI_API_KEY}

# 运行命令
# CMD ["/bin/bash", "jupyter lab --ip=0.0.0.0"]


