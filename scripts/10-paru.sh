# install & configure Paru
#!/bin/sh
set -e

echo "==> [10] Installing and configuring Paru"

# check if paru already installed
if command -v paru >/dev/null 2>&1; then
  echo "--> Paru already installed"
  exit 0
fi

# ensure base-devel and git exist
for pkg in base-devel git; do
  if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
    echo "--> Installing prerequisite: $pkg"
    sudo pacman -S --noconfirm "$pkg"
  fi
done

# create temp build dir
TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

echo "--> Cloning paru-bin from AUR"
git clone --depth 1 https://aur.archlinux.org/paru-bin.git
cd paru-bin

echo "--> Building and installing paru"
makepkg -si --noconfirm

cd ~
rm -rf "$TMP_DIR"

echo "==> [10] Paru installation complete"
