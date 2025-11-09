#!/usr/bin/env bash
# nm-iwd helper: safe to source or execute.
# When sourced: defines functions only.
# When executed: enables strict-mode and runs main.

# Compute SCRIPT_DIR (repo root parent of scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

# shellcheck disable=SC1090
source "$SCRIPT_DIR/scripts/utils.sh"

install_pkgs() {
    local PKG_FILE="$SCRIPT_DIR/scripts/pkgs.txt"

    log "Making sure paru cache doesn't stop Helium Browser installation"
    rm -rf ~/.cache/paru/clone/helium-browser-bin || true

    log "Removing 1password-beta to make room for 1password"
    if pacman -Q 1password-beta &>/dev/null; then
        log "Removing conflicting 1password-beta..."
        paru -Rns 1password-beta --noconfirm || true
    fi

    log "Removing Alacritty to make room for Ghostty"
    if pacman -Q alacritty &>/dev/null; then
        log "Removing conflicting Alacritty..."
        paru -Rns alacritty --noconfirm || true
    fi

    log "Installing and setting up Ghostty as default"
    if ! command -v ghostty &>/dev/null; then
        omarchy-install-terminal ghostty
    else
        log "Ghostty already installed, skipping..."
    fi

    if [ ! -f "$PKG_FILE" ]; then
        log "Package list $PKG_FILE not found; skipping package installation"
        return 0
    fi

    # Read pkgs.txt, ignore empty lines and lines starting with '#'
    pkgs=()
    while IFS= read -r line || [ -n "$line" ]; do
        # Remove inline comments
        line="${line%%#*}"
        # Trim leading/trailing whitespace
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"
        [ -n "$line" ] || continue
        pkgs+=("$line")
    done < "$PKG_FILE"

    if [ ${#pkgs[@]} -eq 0 ]; then
        log "No packages listed in $PKG_FILE; nothing to install"
    else
        log "Installing packages with paru..."
        paru -S --needed --noconfirm "${pkgs[@]}" || log "paru reported an error installing packages"
    fi

    log "Installing Zed via Curl"
    if ! command -v zed &>/dev/null; then
        if curl -f https://zed.dev/install.sh | sh; then
            log "Zed installed successfully"
        else
            log "WARNING: Failed to install Zed"
        fi
    else
        log "Zed already installed, skipping..."
    fi
}
install_pkgs
