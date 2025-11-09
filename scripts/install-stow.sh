#!/bin/sh
set -e

if ! command -v stow >/dev/null 2>&1; then
  echo "Installing stow..."
  sudo pacman -S --noconfirm stow
else
  echo "stow already installed"
fi
