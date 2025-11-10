#!/bin/sh
set -e

echo "==> [80] Setting up custom desktop entries"

# Compute repo root (one level up from scripts/)
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && cd .. && pwd)"

APPLICATION_DIR="$SCRIPT_DIR/.local/share/applications"
ICONS_DIR="$APPLICATION_DIR/icons"

echo "--> Creating application directories"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/applications/icons"

echo "--> Copying .desktop files"
for file in "$APPLICATION_DIR"/*.desktop; do
    [ -f "$file" ] || continue
    basefile="$(basename "$file")"
    echo "    -> $basefile"
    sed "s|/home/pby|$HOME|g" "$file" >"$HOME/.local/share/applications/$basefile"
done

echo "--> Copying icons"
for file in "$ICONS_DIR"/*.png; do
    [ -f "$file" ] || continue
    cp "$file" "$HOME/.local/share/applications/icons/"
done

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
