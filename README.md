# Omarchy-bootstrap

This repository provides an installer to bootstrap my preferred environment on Arch-based Omarchy systems. The installer is composed of small, POSIX-compliant scripts in `./scripts/` that are idempotent and can be run individually.

# Quick install
To download and run the bootstrap installer, run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Furyfree/omarchy-bootstrap/main/bootstrap.sh)
```

# Post-bootstrap notes
- All installer scripts are POSIX-compliant and intended to run with `/bin/sh`.
- Each script is idempotent; you can re-run any individual step if needed (for example: `./scripts/20-packages.sh` from inside the cloned repo).
- The bootstrap process clones this repository into `~/git/omarchy-bootstrap` and clones dotfiles into `~/git/dotfiles-2.0`. The scripts expect dotfiles to be available at `~/git/dotfiles-2.0` for the stow step.

# Switching remotes to SSH
After the bootstrap finishes and once you've added your SSH key to GitHub, you can change the remotes from HTTPS to SSH to enable push/pull using your SSH key.

Switch the bootstrap repo to SSH:
```bash
cd ~/git/omarchy-bootstrap
git remote set-url origin git@github.com:Furyfree/omarchy-bootstrap.git
```

Switch the dotfiles repo to SSH:
```bash
cd ~/git/dotfiles-2.0
git remote set-url origin git@github.com:Furyfree/dotfiles-2.0.git
```

Tip
- Make sure your SSH key is added to GitHub before switching remotes; otherwise `git` over SSH will fail.
- You can run any script directly from the cloned repo. Example:
  - `cd ~/git/omarchy-bootstrap && ./scripts/30-dotfiles.sh`
