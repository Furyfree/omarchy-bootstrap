#!/bin/sh
set -e

echo "==> Running Omarchy Bootstrap"

# Run scripts in order
./scripts/00-prereqs.sh
./scripts/05-shell.sh
./scripts/10-paru.sh
./scripts/15-fonts.sh
./scripts/20-packages.sh
./scripts/30-dotfiles.sh
./scripts/40-hypr.sh
./scripts/50-monitors.sh
./scripts/60-amd.sh
./scripts/70-dev.sh
./scripts/80-desktop-entries.sh
./scripts/90-certs.sh
./scripts/95-wow-addons.sh
./scripts/100-trusted-1password.sh
./scripts/110-defaults.sh
./scripts/120-netstack.sh

# Reload Hyprland if available
if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload || true
fi

echo "PLEASE REBOOT FOR EVERYTHING TO TAKE EFFECT AND CONNECT TO THE WIFI AGAIN"
echo "READ POSTINSTALL.MD"
