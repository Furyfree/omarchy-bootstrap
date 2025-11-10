#!/bin/sh
set -e

DOTFILES="$HOME/git/dotfiles-2.0"
LIST="$PWD/dotfiles.txt"

echo "==> [30] Stowing dotfiles from $DOTFILES"

# ensure dotfiles repo exists
if [ ! -d "$DOTFILES" ]; then
  echo "Error: dotfiles repo not found at $DOTFILES"
  exit 1
fi

# ensure list exists
if [ ! -f "$LIST" ]; then
  echo "Error: dotfiles list not found at $LIST"
  exit 1
fi

cd "$DOTFILES" || exit 1

while IFS= read -r dir || [ -n "$dir" ]; do
  # skip comments or empty lines
  [ -z "$dir" ] && continue
  case "$dir" in
    \#*) continue ;;
  esac

  if [ -d "$DOTFILES/$dir" ]; then
    echo "--> Stowing $dir"
    stow -R "$dir"
  else
    echo "--> Skipping missing directory: $dir"
  fi
done < "$LIST"

echo "==> [30] Dotfiles stow complete"
