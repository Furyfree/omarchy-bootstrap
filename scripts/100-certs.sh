#!/bin/sh
set -e

echo "==> [100] Installing DTU Eduroam certificate"

CERT_SRC="$HOME/git/omarchy-bootstrap/etc/certs/Eduroam_aug2020.pem"
CERT_DST="/etc/certs/Eduroam_aug2020.pem"

if [ ! -f "$CERT_SRC" ]; then
    echo "Error: certificate not found at $CERT_SRC"
    exit 1
fi

sudo mkdir -p /etc/certs
sudo cp "$CERT_SRC" "$CERT_DST"

echo "--> Updating system CA trust"
sudo update-ca-trust

echo "==> [120] Eduroam certificate installation complete"
