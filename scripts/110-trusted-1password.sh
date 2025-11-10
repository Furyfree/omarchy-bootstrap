#!/bin/sh
set -e

echo "==> [110] Adding Helium to 1Password trusted browsers"

# Compute repo root (one level up from scripts/)
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)"
UTILS="$SCRIPT_DIR/scripts/utils.sh"

# Source utils if available
[ -f "$UTILS" ] && . "$UTILS"

echo "--> Creating 1Password config directory"
sudo mkdir -p /etc/1password

echo "--> Allowing Helium browser"
printf "helium-browser\n" | sudo tee /etc/1password/custom_allowed_browsers >/dev/null

echo "--> 1Password trusted browsers updated"


echo "==> [110] 1Password trust setup complete"
