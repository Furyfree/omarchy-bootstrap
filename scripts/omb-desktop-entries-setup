#!/bin/sh
set -e

echo "==> [80] Setting up custom desktop entries"

# Compute repo root (one level up from scripts/)
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)"

APPLICATION_DIR="$SCRIPT_DIR/.local/share/applications"
ICONS_DIR="$SCRIPT_DIR/.local/share/icons"

echo "--> Creating application directories"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"

echo "--> Linking .desktop files"
for file in "$APPLICATION_DIR"/*.desktop; do
    [ -f "$file" ] || continue
    basefile="$(basename "$file")"
    target="$HOME/.local/share/applications/$basefile"

    echo "    -> $basefile"
    ln -sf "$file" "$target"
done


echo "--> Copying icons"
for file in "$ICONS_DIR"/*.png; do
    [ -f "$file" ] || continue
    ln -sf "$file" "$HOME/.local/share/icons/"
done

GIT_TOOLBOX_DIR=$SCRIPT_DIR/opt/jetbrains-toolbox
TOOLBOX_DIR=/opt/jetbrains-toolbox
echo "--> Copying Jetbrains Toolbox icon"
sudo ln -sf $GIT_TOOLBOX_DIR/toolbox.svg $TOOLBOX_DIR

echo "--> Backing up unwanted desktop entries"
# List of entries to disable
for filename in \
    "Basecamp.desktop" \
    "dropbox.desktop" \
    "Figma.desktop" \
    "Google Contacts.desktop" \
    "Google Messages.desktop" \
    "Google Photos.desktop" \
    "HEY.desktop" \
    "Impala.desktop" \
    "WhatsApp.desktop"
do
    f="$HOME/.local/share/applications/$filename"
    if [ -e "$f" ]; then
        mv "$f" "$f.bak"
        echo "    -> backed up $filename"
    fi
done

echo "==> [80] Desktop entry setup complete"
