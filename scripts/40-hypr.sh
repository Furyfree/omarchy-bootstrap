#!/bin/sh
set -e

echo "==> [40] Setting up Hyprland overrides"

HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
OVERRIDES_CONFIG="~/git/dotfiles-2.0/hyprland/.config/hypr/overrides.conf"
SOURCE_LINE="source = $OVERRIDES_CONFIG"

# Check if Hyprland config exists
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Error: Hyprland config not found at $HYPRLAND_CONFIG"
    echo "Please install Hyprland first."
    exit 1
fi

# Check if overrides config exists
if [ ! -f "$OVERRIDES_CONFIG" ]; then
    echo "Error: Overrides config not found at $OVERRIDES_CONFIG"
    exit 1
fi

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
