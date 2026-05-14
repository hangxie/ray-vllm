# Use the Ray image as the foundation
FROM rayproject/ray:2.55.1-extra-py312-cu124

# Set environment variables
ENV PIP_NO_CACHE_DIR=1

USER root
# Install git-lfs in case you need to verify model integrity later
RUN apt-get update && apt-get install -y git-lfs && rm -rf /var/lib/apt/lists/*
USER ray

# Install dependencies
# vLLM 0.19.1 and Scipy
RUN pip install --upgrade pip && \
    pip install "vllm==0.19.1" "scipy>=1.14.0"

# Verify installation
RUN python3 -c "import vllm; print('vLLM version:', vllm.__version__)"
