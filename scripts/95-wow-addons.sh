#!/bin/sh
set -e

echo "==> [90] Installing Wago and WowUp Addon Managers"

# --- Wago setup ---
WAGO_DIR="$HOME/Apps/Wago"
mkdir -p "$WAGO_DIR"
curl -fsSL "https://wago-addons.ams3.digitaloceanspaces.com/wagoapp/WagoApp_2.8.0.AppImage" \
  -o "$WAGO_DIR/Wago.AppImage"
chmod +x "$WAGO_DIR/Wago.AppImage"
echo "--> Wago App installed at $WAGO_DIR/Wago.AppImage"

# Register scheme handler
if [ -f "$HOME/.local/share/applications/Wago.desktop" ]; then
  xdg-mime default Wago.desktop x-scheme-handler/wago-app
  echo "--> Registered x-scheme-handler for Wago"
fi

# --- WowUp setup ---
WOWUP_DIR="$HOME/Apps/WowUp"
mkdir -p "$WOWUP_DIR"
curl -fsSL "https://github.com/WowUp/WowUp.CF/releases/download/v2.20.0/WowUp-CF-2.20.0.AppImage" \
  -o "$WOWUP_DIR/WowUp.AppImage"
chmod +x "$WOWUP_DIR/WowUp.AppImage"
echo "--> WowUp installed at $WOWUP_DIR/WowUp.AppImage"

# Register scheme handler if desktop file exists
if [ -f "$HOME/.local/share/applications/Wowup.desktop" ]; then
  xdg-mime default Wowup.desktop x-scheme-handler/wowup-app
  echo "--> Registered x-scheme-handler for WowUp"
fi

echo "==> [90] Finished installing Wago and WowUp Addon Managers"
