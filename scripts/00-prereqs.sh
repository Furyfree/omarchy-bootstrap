# checks pacman, installs stow, curl, git
#!/bin/sh
set -e

echo "==> [00] Checking prerequisites"

# ensure pacman exists
if ! command -v pacman >/dev/null 2>&1; then
  echo "Error: pacman not found. This script is Arch-only."
  exit 1
fi

# packages to ensure are installed
for pkg in stow curl git; do
  if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
    echo "--> Installing missing package: $pkg"
    sudo pacman -S --noconfirm "$pkg"
  else
    echo "--> $pkg already installed"
  fi
done

echo "==> [00] Prerequisite check complete"
