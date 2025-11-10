#!/bin/sh
set -e

echo "==> [40] Setting up Hyprland overrides"

DOTFILES="$HOME/git/dotfiles"
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
SOURCE_LINE="source = ~/.config/hypr/overrides.conf"

# Ensure Hyprland config exists
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Error: Hyprland config not found at $HYPRLAND_CONFIG"
    exit 1
fi

# Ensure overrides exist
if [ ! -f "$DOTFILES/hyprland/.config/hypr/overrides.conf" ]; then
    echo "Error: Overrides config not found in repo"
    exit 1
fi

echo "--> Deploying overrides with stow"
cd "$DOTFILES"

# Check if overrides.conf already exists in the target directory
if [ ! -f "$HOME/.config/hypr/overrides.conf" ]; then
    echo "--> Stowing overrides.conf"
    stow -R -t "$HOME" --no-folding hyprland/.config/hypr/overrides.conf
else
    echo "--> overrides.conf already exists, skipping stow"
fi

# Check if overrides.d directory exists in the target directory
if [ ! -d "$HOME/.config/hypr/overrides.d" ]; then
    echo "--> Stowing overrides.d"
    stow -R -t "$HOME" --no-folding hyprland/.config/hypr/overrides.d
else
    echo "--> overrides.d already exists, skipping stow"
fi

# Add source line to hyprland.conf if missing
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
