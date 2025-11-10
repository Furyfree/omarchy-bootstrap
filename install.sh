#!/bin/sh
set -e

echo "==> Running Omarchy Bootstrap"

# Run scripts in order
./scripts/00-prereqs.sh
./scripts/10-paru.sh
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

echo "==> Omarchy Bootstrap Complete"
