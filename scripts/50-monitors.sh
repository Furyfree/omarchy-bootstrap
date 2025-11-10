#!/bin/sh
set -e

echo "==> [50] Setting monitor configuration"

HYPR_DIR="$HOME/.config/hypr"
MON_DIR="$HYPR_DIR/monitors"
mkdir -p "$MON_DIR"

HOST="$(hostname)"

case "$HOST" in
  arctop)
    echo "--> Detected host: arctop"
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
