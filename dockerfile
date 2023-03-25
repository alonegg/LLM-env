# 使用安装了pytorch的ubuntu镜像作为基础镜像
FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime


# 设置工作目录
WORKDIR /app

# 安装git
RUN apt-get update && \
    apt-get install -y git

# 克隆仓库
RUN git clone https://github.com/microsoft/visual-chatgpt.git

# 切换到仓库目录
WORKDIR /app/visual-chatgpt

# 安装依赖
RUN pip install -r requirements.txt

# 设置环境变量
ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=${OPENAI_API_KEY}

# 运行命令
CMD ["python", "visual_chatgpt.py", "--load", "ImageCaptioning_cuda:0,ImageEditing_cuda:0,Text2Image_cuda:1,Image2Canny_cpu,CannyText2Image_cuda:1"]


