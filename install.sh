#!/bin/sh
set -e

echo "==> Running Omarchy Bootstrap"

# 0. Make scripts available globally
./scripts/omb-scripts-install


# --- ASK QUESTIONS FIRST & SAVE ANSWERS ---
echo -n "Run AI clean? (wipe ollama, models, data) [y/N]: "
read AI_CLEAN

echo -n "Install AI stack (Ollama, WebUI, models)? [y/N]: "
read AI_SETUP

echo -n "Install Wootility webapp + udev rules? [y/N]: "
read WOOTILITY

echo -n "Run Gaming Setup? (Steam, gamemode, faugus) [y/N]: "
read GAMING_SETUP

echo -n "Install WoW Addon Managers? (Wago, WowUp) [y/N]: "
read WOW_ADDONS


# --- RUN CORE SCRIPTS ---
omb-bootstrap-prereqs
omb-shell-setup
omb-paru-setup
omb-fonts-setup
omb-install-packages
omb-dotfiles-install
omb-ghostty-setup
omb-hyprland-setup
omb-monitor-setup
omb-amd-setup
omb-dev-env-setup
omb-desktop-entries-setup
omb-certs-install
omb-trusted-1password-setup
omb-defaults-setup
omb-zed-extensions
omb-netstack-setup


# --- OPTIONALS (BASED ON EARLY ANSWERS) ---
if [ "$AI_CLEAN" = "y" ] || [ "$AI_CLEAN" = "Y" ]; then
    omb-ai-clean
fi

if [ "$AI_SETUP" = "y" ] || [ "$AI_SETUP" = "Y" ]; then
    omb-ai-setup
fi

if [ "$WOOTILITY" = "y" ] || [ "$WOOTILITY" = "Y" ]; then
    omb-wootility-setup
fi

if [ "$GAMING_SETUP" = "y" ] || [ "$GAMING_SETUP" = "Y" ]; then
    omb-gaming-setup
fi

if [ "$WOW_ADDONS" = "y" ] || [ "$WOW_ADDONS" = "Y" ]; then
    omb-wow-addons-setup
fi

# --- FINALIZE ---
if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload || true
fi

echo
echo "==> Omarchy Bootstrap complete."
echo "==> All commands are now available globally with the 'omb-' prefix."
echo "Example: omb-dotfiles-install"
echo
echo "PLEASE REBOOT to finalize everything and reconnect to Wi-Fi."
echo "Read POSTINSTALL.MD"
