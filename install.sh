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
./scripts/70-netstack.sh
./scripts/80-dev.sh
./scripts/90-desktop-entries.sh
./scripts/100-certs.sh
./scripts/110-trusted-1password.sh
./scripts/120-defaults.sh

# Reload Hyprland if available
if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload || true
fi

echo "==> Omarchy Bootstrap Complete"
echo "PLEASE REBOOT FOR EVERYTHING TO TAKE EFFECT"
echo "READ POSTINSTALL.MD"
