#!/bin/sh
set -e

HYPR_DIR="$HOME/.config/hypr"
MON_DIR="$HYPR_DIR/monitors"
mkdir -p "$MON_DIR"

# pick config
if [[ "$(hostname)" == "arctop" ]]; then
  ln -sf "$MON_DIR/desktop.conf" "$MON_DIR/current.conf"
elif [[ "$(hostname)" == "archbook" ]]; then
  ln -sf "$MON_DIR/laptop.conf" "$MON_DIR/current.conf"
else
  echo "Unknown host, leaving current.conf unchanged"
fi
