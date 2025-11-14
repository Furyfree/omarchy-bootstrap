#!/bin/sh
set -e

HOSTNAME=$(hostname)

echo "==> [75] Setting up local AI and Codex"

# Check if Opencode is installed
if ! command -v opencode >/dev/null 2>&1; then
    echo "Opencode not found, installing..."
    curl -fsSL https://opencode.ai/install | bash || true
else
    echo "Opencode is already installed."
fi

# Check if Codex is installed
if ! command -v codex >/dev/null 2>&1; then
    echo "Codex not found, installing..."
    npm i -g @openai/codex || true
else
    echo "Codex is already installed."
fi

# Check if Ollama is installed
if ! command -v ollama >/dev/null 2>&1; then
    echo "Ollama not found, installing..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "Ollama is already installed."
fi
sudo systemctl enable --now ollama

# Models (ollama pull is already idempotent)
ollama pull deepseek-r1:14b
ollama pull deepseek-r1:7b
ollama pull qwen2.5-coder:7b
ollama pull qwen2.5-coder:14b
ollama pull qwen3:14b
ollama pull qwen3:8b
ollama pull llama3.1:8b
ollama pull gpt-oss:20b

# Stop existing container if it exists, but don't throw an error if missing
docker rm -f open-webui 2>/dev/null || true

# Desktop vs laptop
if [ "$HOSTNAME" = "archtop" ]; then
    echo "--> Starting GPU OpenWebUI (desktop)"
    # If container doesn't exist, create and start it
    docker run -d \
      -p 3000:8080 \
      --gpus all \
      --add-host=host.docker.internal:host-gateway \
      -v open-webui:/app/backend/data \
      --name open-webui \
      --restart always \
      ghcr.io/open-webui/open-webui:cuda

elif [ "$HOSTNAME" = "archbook" ]; then
    echo "--> Starting CPU OpenWebUI with Ollama inside (laptop)"
    # If container doesn't exist, create and start it
    docker run -d \
      -p 3000:8080 \
      -v ollama:/root/.ollama \
      -v open-webui:/app/backend/data \
      --name open-webui \
      --restart always \
      ghcr.io/open-webui/open-webui:ollama

else
    echo "Unknown hostname: $HOSTNAME"
    exit 1
fi
