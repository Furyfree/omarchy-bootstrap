# PBY’s Postinstall Guide

Post-install checklist after running the `omarchy-bootstrap` setup.
This covers remaining manual steps for Helium, Zed, JetBrains, and VPN configuration.

---

## Browser Configuration

### Helium Browser Extensions
- **1Password** – Password manager integration
- **uBlock Origin** – Ad/tracker blocker
- **Dark Reader** – Universal dark mode
- **Bookmarkhub** – Centralized bookmark management (credentials stored in 1Password)

---

### Helium Preferences

#### Search
- **Default Search Engine:** Google
- **Suggestions from Search Engine:** Disabled

#### Appearance
- **Theme:** Helium Colors
- **Mode:** Device
- **Show Home Button:** Disabled
- **Show Bookmarks Bar:** Disabled
- **Open New Tabs Next to Active Tab:** Disabled
- **Show Tab Groups in Bookmarks Bar:** Disabled
- **Automatically Pin New Tab Groups:** Enabled
- **Side Panel Position:** Right
- **Tab Preview Images:** Enabled
- **Tab Memory Usage:** Enabled
- **Use System Title Bar and Borders:** Enabled

#### Languages & Spell Check
- **Preferred Languages:**
  - English (United States)
  - English
  - Danish
- **Spell Check Enabled For:**
  - English (United States)
  - Danish

#### Start Page Customization
- **Toolbar:** Only **Extensions** and **Main Menu** enabled
- **Show Shortcuts:** Disabled


---

## Zed Editor Configuration

**Theme:** Catppuccin Mocha (match system)
**Font:** CaskaydiaMono Nerd Font
**Icons:** Catppuccin Mocha icon set
**Extensions:** HTML, TOML, Dockerfile, Java, SQL, Make, Svelte, LaTeX, Terraform, Lua, XML, Zig, C#, Swift, LOG, Kotilin, Docker Compose, GraphQL, Nix, Rainbow CSV, ini, golangci-lint, Ansible, Nginx, F#

---

## JetBrains Setup

**Toolbox Configuration:**
- Launch JetBrains Toolbox after install
- Log in with your JetBrains account
- Enable “Settings Sync” for automatic configuration sharing

---

## Limine (If Dualboot)

If you dual-boot with Windows, you need to add the Windows EFI entry to the Limine boot menu:

```bash
sudo limine-scan
```
Select the Windows Boot Manager entry (usually option 1) to add it to Limine.

---

## VPN Configuration

**Proton VPN:**
Login and set preferences manually through the app.

**WireGuard (Unifi):**
1. Go to Unifi Console → Settings → VPN → VPN Server → Byrne VPN Wireguard
2. Add new client and download config
3. Import into NetworkManager:
   nmcli connection import type wireguard file ~/Downloads/wg0.conf
4. Rename connection:
   nmcli connection modify wg0 connection.id "unifi-wg"

Usage:
nmcli connection up unifi-wg
nmcli connection down unifi-wg

**DTU VPN Setup:**
nmcli connection add type vpn vpn-type openconnect con-name dtu-vpn +vpn.data "gateway=vpn.dtu.dk,protocol=anyconnect"

Set User Agent to `AnyConnect` in NetworkManager UI.

Usage:
nmcli connection up dtu-vpn
nmcli connection down dtu-vpn

---

**System ready — enjoy your Omarchy setup!**
