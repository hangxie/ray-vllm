#!/bin/bash

# 1. Handle the Ray/vLLM path mismatch (Workaround for v0.19.1)
export PYTHONPATH=$PYTHONPATH:$(python3 -c "import vllm; import os; print(os.path.dirname(vllm.__file__))")

# 2. Launch the vLLM OpenAI-compatible server
# We point to the local folder where we baked the model
python3 -m vllm.entrypoints.openai.api_server \
    --model /home/ray/model_cache \
    --served-model-name qwen3 \
    --trust-remote-code \
    --host 0.0.0.0 \
    --port 8000 \
    --tensor-parallel-size ${RAY_RESOURCES_GPU:-1}
