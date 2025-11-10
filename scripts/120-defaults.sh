#!/bin/sh
set -e

echo "==> [120] Setting default applications (Ghostty + Helium)"

# --- Set Ghostty as default terminal ---
if command -v omarchy-install-terminal >/dev/null 2>&1; then
    echo "--> Setting Ghostty as default terminal"
    omarchy-install-terminal ghostty || true
else
    echo "--> omarchy-install-terminal not found; skipping Ghostty setup"
fi

# --- Set Helium as default browser ---
echo "--> Setting Helium Browser as default"
xdg-settings set default-web-browser helium-browser.desktop || true

# --- Reload Hyprland if available ---
if command -v hyprctl >/dev/null 2>&1; then
    echo "--> Reloading Hyprland configuration"
    hyprctl reload || true
fi

# --- Add Widevine DRM support for Helium ---
echo "--> Adding Widevine DRM support for Helium Browser"
if [ -d /usr/lib/chromium/WidevineCdm ] && [ -d /opt/helium-browser-bin ]; then
    sudo ln -sfn /usr/lib/chromium/WidevineCdm /opt/helium-browser-bin/WidevineCdm
    echo "   Symlink created successfully"
else
    echo "   WidevineCdm or Helium browser directory missing; skipping DRM link"
fi

echo "==> [120] Default application setup complete"
