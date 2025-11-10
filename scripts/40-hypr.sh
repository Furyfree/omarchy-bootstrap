#!/bin/sh
set -e

echo "==> [40] Setting up Hyprland overrides"

HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
OVERRIDES_SRC="$HOME/git/dotfiles-2.0/hyprland/.config/hypr/overrides.conf"
OVERRIDES_DST="$HOME/.config/hypr/overrides.conf"
SOURCE_LINE="source = ~/.config/hypr/overrides.conf"

# Ensure Hyprland config exists
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Error: Hyprland config not found at $HYPRLAND_CONFIG"
    exit 1
fi

# Ensure overrides source exists
if [ ! -f "$OVERRIDES_SRC" ]; then
    echo "Error: Overrides config not found at $OVERRIDES_SRC"
    exit 1
fi

# Copy or update overrides.conf
echo "--> Copying overrides.conf to Hyprland config directory"
mkdir -p "$HOME/.config/hypr"
cp "$OVERRIDES_SRC" "$OVERRIDES_DST"

# Add source line if missing
if grep -Fxq "$SOURCE_LINE" "$HYPRLAND_CONFIG"; then
    echo "--> Source line already present"
else
    echo "--> Adding source line to $HYPRLAND_CONFIG"
    {
        echo ""
        echo "$SOURCE_LINE"
    } >> "$HYPRLAND_CONFIG"
    echo "--> Source line added"
fi

echo "==> [40] Hyprland overrides setup complete"
