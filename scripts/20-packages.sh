#!/bin/sh
set -e

echo "==> [20] Installing packages from packages.txt"

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)"
LIST="$SCRIPT_DIR/packages.txt"

if [ ! -f "$LIST" ]; then
  echo "Error: packages.txt not found at $LIST"
  exit 1
fi

# Check if 1password-beta is installed
if pacman -Qi 1password-beta >/dev/null 2>&1; then
  echo "--> Removing 1password-beta"
  sudo pacman -Rns 1password-beta --noconfirm
else
  echo "--> 1password-beta is not installed, skipping removal"
fi

while IFS= read -r pkg || [ -n "$pkg" ]; do
  # Skip empty lines and comments
  case "$pkg" in
    ""|\#*) continue ;;
  esac

  if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
    echo "--> Installing $pkg"
    paru -S --noconfirm "$pkg"
  else
    echo "--> $pkg already installed"
  fi
done < "$LIST"

# Handle Zed installation
if ! command -v zed >/dev/null 2>&1; then
  echo "--> Installing Zed editor"
  if curl -fsSL https://zed.dev/install.sh | sh; then
    echo "--> Zed installed successfully"
  else
    echo "WARNING: Failed to install Zed"
  fi
else
  echo "--> Zed already installed, skipping"
fi

if ! command -v steam >/dev/null 2>&1; then
  if command -v omarchy-install-steam >/dev/null 2>&1; then
    echo "--> Installing Steam"
    omarchy-install-steam
    echo "--> Steam installed successfully"
  else
    echo "WARNING: omarchy-install-steam command not found"
  fi
else
  echo "--> Steam already installed, skipping"
fi


# Remove Alacritty from pacman if installed
if pacman -Qi alacritty >/dev/null 2>&1; then
  echo "--> Removing conflicting Alacritty package"
  paru -Rns alacritty --noconfirm || true
else
  echo "--> Alacritty not installed via pacman, skipping"
fi

echo "==> [20] Package installation complete"
