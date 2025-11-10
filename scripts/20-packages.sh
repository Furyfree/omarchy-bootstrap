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

echo "==> [20] Package installation complete"
