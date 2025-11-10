#!/bin/sh
set -e

echo "==> [80] Installing development tools"

# Compute SCRIPT_DIR (repo root parent of scripts/)
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)"
UTILS="$SCRIPT_DIR/scripts/utils.sh"

# Source utils if available
[ -f "$UTILS" ] && . "$UTILS"

# --- Python: uv installer ---
install_python_tools() {
    echo "--> Installing uv for Python management"
    if ! command -v uv >/dev/null 2>&1; then
        curl -fsSL https://astral.sh/uv/install.sh | sh
    else
        echo "--> uv already installed, skipping"
    fi
}

# --- Rust: rustup installer ---
install_rustup() {
    echo "--> Installing Rustup"
    if ! command -v rustc >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    else
        echo "--> Rust already installed, skipping"
    fi
}

# --- Java: via mise ---
install_java() {
    echo "--> Installing Java versions via mise"
    if ! command -v mise >/dev/null 2>&1; then
        echo "!! mise not found; skipping Java setup"
        return 1
    fi

    mise use -g java@latest
    mise use -g java@21
    mise use -g java@25
    mise use -g java@corretto-21
    mise use -g java@corretto-25

    echo "--> Setting Corretto 25 as global default"
    mise use -g java@corretto-25
}

# --- Run all setups ---
install_rustup
install_python_tools
install_java

echo "==> [80] Development environment setup complete"
