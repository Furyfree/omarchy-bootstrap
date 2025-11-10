#!/bin/sh
set -e

echo "==> [50] Setting monitor configuration"

HYPR_DIR="$HOME/.config/hypr"
MON_DIR="$HYPR_DIR/monitors"
REPO_MON_DIR="$HOME/git/dotfiles-2.0/hyprland/.config/hypr/monitors"
mkdir -p "$MON_DIR"

# Symlink laptop.conf and desktop.conf directly from repo
for f in desktop.conf laptop.conf; do
    if [ -f "$REPO_MON_DIR/$f" ]; then
        ln -sf "$REPO_MON_DIR/$f" "$MON_DIR/$f"
        echo "--> Linked $f from dotfiles repo"
    else
        echo "--> Missing $REPO_MON_DIR/$f (skipping)"
    fi
done

HOST="$(hostname | tr '[:upper:]' '[:lower:]')"

case "$HOST" in
  arctop)
    echo "--> Detected host: archtop"
    ln -sf "$MON_DIR/desktop.conf" "$MON_DIR/current.conf"
    ;;
  archbook)
    echo "--> Detected host: archbook"
    ln -sf "$MON_DIR/laptop.conf" "$MON_DIR/current.conf"
    ;;
  *)
    echo "--> Unknown host ($HOST), leaving current.conf unchanged"
    ;;
esac

echo "==> [50] Monitor setup complete"
