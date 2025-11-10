#!/bin/sh
set -e

echo "==> Omarchy Bootstrap Starting"

GIT_DIR="$HOME/git"
BOOTSTRAP_REPO="https://github.com/Furyfree/omarchy-bootstrap.git"
DOTFILES_REPO="https://github.com/Furyfree/dotfiles.git"

mkdir -p "$GIT_DIR"

# --- Clone omarchy-bootstrap ---
if [ ! -d "$GIT_DIR/omarchy-bootstrap/.git" ]; then
    echo "--> Cloning omarchy-bootstrap into $GIT_DIR"
    git clone "$BOOTSTRAP_REPO" "$GIT_DIR/omarchy-bootstrap"
else
    echo "--> omarchy-bootstrap already exists, pulling latest changes"
    git -C "$GIT_DIR/omarchy-bootstrap" pull
fi

# --- Clone dotfiles ---
if [ ! -d "$GIT_DIR/dotfiles/.git" ]; then
    echo "--> Cloning dotfiles into $GIT_DIR"
    git clone "$DOTFILES_REPO" "$GIT_DIR/dotfiles"
else
    echo "--> dotfiles already exists, pulling latest changes"
    git -C "$GIT_DIR/dotfiles" pull
fi

# --- Run the bootstrap install sequence ---
echo "--> Running install.sh from omarchy-bootstrap"
cd "$GIT_DIR/omarchy-bootstrap"
./install.sh

echo "==> Omarchy Bootstrap Complete"
