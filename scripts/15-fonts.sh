#!/bin/sh
set -e

paru -S --noconfirm --needed \
  noto-fonts-emoji \
  ttf-font-awesome

fc-cache -v
