#!/bin/sh
set -e

echo "==> [75] Cleaning out OpenWebUI, Ollama and related data"

# --- Systemd cleanup ---
echo "--> Removing systemd services"
sudo systemctl disable --now openwebui 2>/dev/null || true
sudo rm -f /etc/systemd/system/openwebui.service

sudo systemctl disable --now ollama 2>/dev/null || true
sudo rm -f /etc/systemd/system/ollama.service

sudo systemctl daemon-reload

# --- Docker containers ---
echo "--> Removing Docker containers"
docker rm -f open-webui 2>/dev/null || true

# --- Docker volumes ---
echo "--> Removing Docker volumes"
docker volume rm open-webui 2>/dev/null || true
docker volume rm ollama 2>/dev/null || true

# --- Docker images ---
echo "--> Removing Docker images"
docker images | grep "open-webui" | awk '{print $3}' | xargs -r docker rmi -f
docker images | grep "ollama"     | awk '{print $3}' | xargs -r docker rmi -f

# --- Ollama user + group ---
echo "--> Removing Ollama user and group"
sudo userdel ollama 2>/dev/null || true
sudo groupdel ollama 2>/dev/null || true

# --- Ollama directories ---
echo "--> Removing Ollama directories"
sudo rm -rf /usr/local/bin/ollama
sudo rm -rf /usr/local/lib/ollama
sudo rm -rf /usr/share/ollama
sudo rm -rf ~/.ollama

# --- OpenWebUI leftover configs ---
echo "--> Removing OpenWebUI leftover configs"
sudo rm -rf /usr/local/share/open-webui 2>/dev/null || true
sudo rm -rf ~/.config/open-webui 2>/dev/null || true

# --- Restart Docker (optional but recommended)
echo "--> Restarting Docker"
sudo systemctl restart docker

echo "==> Cleanup complete. System is clean."
