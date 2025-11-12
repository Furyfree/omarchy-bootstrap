#!/bin/sh
set -e

echo "==> [90] Installing Wago Addon Manager"
mkdir -p "$HOME/Apps/Wago"
curl -fsSL "https://wago-addons.ams3.digitaloceanspaces.com/wagoapp/WagoApp_2.8.0.AppImage" \
  -o "$HOME/Apps/Wago/Wago.AppImage"
chmod +x "$HOME/Apps/Wago/Wago.AppImage"
echo "--> Wago App installed at ~/Apps/Wago/Wago.AppImage"
