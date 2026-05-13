FROM --platform=linux/x86_64 python:3.14-slim

ARG PACKAGES="git curl ca-certificates vim wget unzip build-essential cmake jq"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=on
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_PROJECT_ENVIRONMENT="/usr/local/"
ENV UV_HTTP_TIMEOUT=999

RUN apt-get update && apt-get install -y --no-install-recommends ${PACKAGES}

RUN pip install -U pip
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm7.2
RUN pip install "transformers[serving]" requests pillow
RUN pip install flash-linear-attention

WORKDIR /app
# Qwen/Qwen3.5-0.8B
transformers serve Qwen/Qwen3.5-0.8B \
  --host 0.0.0.0 \
  --port 8000 \
  --dtype bfloat16 \
  --continuous-batching \
  --model-timeout -1
