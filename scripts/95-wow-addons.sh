#!/bin/sh
set -e

echo "==> [90] Installing Wago and WowUp Addon Managers"

# --- Wago setup ---
WAGO_DIR="$HOME/Apps/Wago"
WAGO_FILE="$WAGO_DIR/Wago.AppImage"
mkdir -p "$WAGO_DIR"

if [ -f "$WAGO_FILE" ]; then
  echo "--> Wago AppImage already exists at $WAGO_FILE, skipping download"
else
  echo "--> Downloading Wago AppImage..."
  curl -fL --retry 3 --retry-delay 2 \
    -o "$WAGO_FILE" \
    "https://wago-addons.ams3.digitaloceanspaces.com/wagoapp/WagoApp_2.8.0.AppImage"
  chmod +x "$WAGO_FILE"
  echo "--> Wago App installed at $WAGO_FILE"
fi

# Register scheme handler if desktop file exists
if [ -f "$HOME/.local/share/applications/Wago.desktop" ]; then
  xdg-mime default Wago.desktop x-scheme-handler/wago-app
  echo "--> Registered x-scheme-handler for Wago"
fi

# --- WowUp setup ---
WOWUP_DIR="$HOME/Apps/WowUp"
WOWUP_FILE="$WOWUP_DIR/WowUp.AppImage"
mkdir -p "$WOWUP_DIR"

if [ -f "$WOWUP_FILE" ]; then
  echo "--> WowUp AppImage already exists at $WOWUP_FILE, skipping download"
else
  echo "--> Downloading WowUp AppImage..."
  curl -fL --retry 3 --retry-delay 2 \
    -o "$WOWUP_FILE" \
    "https://github.com/WowUp/WowUp.CF/releases/download/v2.20.0/WowUp-CF-2.20.0.AppImage"
  chmod +x "$WOWUP_FILE"
  echo "--> WowUp installed at $WOWUP_FILE"
fi

# Register scheme handler if desktop file exists
if [ -f "$HOME/.local/share/applications/Wowup.desktop" ]; then
  xdg-mime default Wowup.desktop x-scheme-handler/wowup-app
  echo "--> Registered x-scheme-handler for WowUp"
fi

echo "==> [90] Finished installing Wago and WowUp Addon Managers"
