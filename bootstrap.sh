#!/bin/sh
set -e

echo "==> Omarchy Bootstrap Starting"

GIT_DIR="$HOME/git"
BOOTSTRAP_REPO="https://github.com/Furyfree/omarchy-bootstrap.git"
DOTFILES_REPO="https://github.com/Furyfree/dotfiles-2.0.git"

mkdir -p "$GIT_DIR"

# --- Clone omarchy-bootstrap ---
if [ ! -d "$GIT_DIR/omarchy-bootstrap/.git" ]; then
    echo "--> Cloning omarchy-bootstrap into $GIT_DIR"
    git clone "$BOOTSTRAP_REPO" "$GIT_DIR/omarchy-bootstrap"
else
    echo "--> omarchy-bootstrap already exists, pulling latest changes"
    git -C "$GIT_DIR/omarchy-bootstrap" pull
fi

# --- Clone dotfiles-2.0 ---
if [ ! -d "$GIT_DIR/dotfiles-2.0/.git" ]; then
    echo "--> Cloning dotfiles-2.0 into $GIT_DIR"
    git clone "$DOTFILES_REPO" "$GIT_DIR/dotfiles-2.0"
else
    echo "--> dotfiles-2.0 already exists, pulling latest changes"
    git -C "$GIT_DIR/dotfiles-2.0" pull
fi

# --- Run the bootstrap install sequence ---
echo "--> Running install.sh from omarchy-bootstrap"
cd "$GIT_DIR/omarchy-bootstrap"
./install.sh

echo "==> Omarchy Bootstrap Complete"
