#!/usr/bin/env bash
# Bootstraps this flake onto a fresh NixOS install.
# Run as your normal user (it uses sudo where needed):
#   bash <(curl -fsSL -H "Authorization: token $GH_TOKEN" \
#     https://raw.githubusercontent.com/CoryJYoung/NixOS-laptop/main/install.sh)
set -euo pipefail

REPO="${REPO:-https://github.com/CoryJYoung/NixOS-laptop.git}"
DEST="${DEST:-$HOME/nixos-config}"
HOST="${HOST:-laptop}"
HW="modules/hosts/$HOST/_hardware-configuration.nix"

# git isn't guaranteed on a fresh install, so run it through nix-shell
git() { nix-shell -p git --run "git $(printf '%q ' "$@")"; }

if [ ! -d "$DEST/.git" ]; then
  echo ">> Cloning $REPO into $DEST"
  if [ -n "${GH_TOKEN:-}" ]; then
    git clone "https://x-access-token:${GH_TOKEN}@${REPO#https://}" "$DEST"
    git -C "$DEST" remote set-url origin "$REPO"
  else
    git clone "$REPO" "$DEST"   # will prompt for username + token
  fi
fi

cd "$DEST"

if [ ! -f "$HW" ]; then
  echo ">> Generating hardware config for this machine"
  sudo nixos-generate-config --show-hardware-config > "$HW"
fi
# Flakes only see files git knows about
git add "$HW"

echo ">> Building and switching to .#$HOST"
# Nix shells out to git to read a git+file flake, so git must be on PATH for
# the rebuild too (a fresh install has none until this first switch adds it).
sudo nix-shell -p git --run \
  "nixos-rebuild switch --flake '.#$HOST' --option experimental-features 'nix-command flakes'"

echo ">> Done. Commit the hardware config with:"
echo "   cd $DEST && git commit -m 'Add laptop hardware config' && git push"
