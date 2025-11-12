#!/bin/sh
set -e

echo "==> [40] Setting up Hyprland overrides"

DOTFILES="$HOME/git/dotfiles"
HYPR_DIR="$HOME/.config/hypr"
HYPRLAND_CONFIG="$HYPR_DIR/hyprland.conf"
SOURCE_LINE="source = ~/.config/hypr/overrides.conf"

SRC_CONF="$DOTFILES/hyprland/.config/hypr/overrides.conf"
SRC_DIR="$DOTFILES/hyprland/.config/hypr/overrides.d"
TARGET_CONF="$HYPR_DIR/overrides.conf"
TARGET_DIR="$HYPR_DIR/overrides.d"

# Ensure Hyprland config exists
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Error: Hyprland config not found at $HYPRLAND_CONFIG"
    exit 1
fi

# Ensure source files exist
if [ ! -f "$SRC_CONF" ]; then
    echo "Error: overrides.conf not found in repo"
    exit 1
fi
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: overrides.d directory not found in repo"
    exit 1
fi

echo "--> Deploying overrides via symlinks"
mkdir -p "$HYPR_DIR"

# Handle overrides.conf
if [ -L "$TARGET_CONF" ]; then
    LINK_TARGET="$(readlink "$TARGET_CONF")"
    if [ "$LINK_TARGET" = "$SRC_CONF" ]; then
        echo "--> Correct symlink for overrides.conf already exists, skipping"
    else
        echo "--> Updating symlink for overrides.conf (was linked to $LINK_TARGET)"
        rm -f "$TARGET_CONF"
        ln -s "$SRC_CONF" "$TARGET_CONF"
    fi
elif [ -e "$TARGET_CONF" ]; then
    BACKUP_FILE="$TARGET_CONF.backup_$(date +%Y%m%d-%H%M%S)"
    echo "--> Backing up existing overrides.conf to $BACKUP_FILE"
    cp "$TARGET_CONF" "$BACKUP_FILE"
    rm -f "$TARGET_CONF"
    ln -s "$SRC_CONF" "$TARGET_CONF"
    echo "--> Replaced with symlink"
else
    ln -s "$SRC_CONF" "$TARGET_CONF"
    echo "--> Symlink created for overrides.conf"
fi

# Handle overrides.d directory
if [ -L "$TARGET_DIR" ]; then
    LINK_TARGET="$(readlink "$TARGET_DIR")"
    if [ "$LINK_TARGET" = "$SRC_DIR" ]; then
        echo "--> Correct symlink for overrides.d already exists, skipping"
    else
        echo "--> Updating symlink for overrides.d (was linked to $LINK_TARGET)"
        rm -f "$TARGET_DIR"
        ln -s "$SRC_DIR" "$TARGET_DIR"
    fi
elif [ -d "$TARGET_DIR" ]; then
    BACKUP_DIR="${TARGET_DIR}_backup_$(date +%Y%m%d-%H%M%S)"
    echo "--> Backing up existing overrides.d to $BACKUP_DIR"
    cp -r "$TARGET_DIR" "$BACKUP_DIR"
    rm -rf "$TARGET_DIR"
    ln -s "$SRC_DIR" "$TARGET_DIR"
    echo "--> Replaced with symlink"
else
    ln -s "$SRC_DIR" "$TARGET_DIR"
    echo "--> Symlink created for overrides.d"
fi

# Add source line to hyprland.conf if missing
if grep -Fxq "$SOURCE_LINE" "$HYPRLAND_CONFIG"; then
    echo "--> Source line already present in hyprland.conf"
else
    echo "--> Adding source line to $HYPRLAND_CONFIG"
    {
        echo ""
        echo "$SOURCE_LINE"
    } >> "$HYPRLAND_CONFIG"
    echo "--> Source line added"
fi

echo "==> [40] Hyprland overrides setup complete"
