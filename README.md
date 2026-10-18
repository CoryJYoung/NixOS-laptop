# NixOS laptop

Dendritic NixOS flake ([flake-parts](https://flake.parts) + [import-tree](https://github.com/vic/import-tree)) with niri and kitty.

## Install on a fresh NixOS

The repo is private, so curl needs a GitHub token (a fine-grained token with read access to this repo is enough):

```sh
export GH_TOKEN=github_pat_...
bash <(curl -fsSL -H "Authorization: token $GH_TOKEN" \
  https://raw.githubusercontent.com/CoryJYoung/NixOS-laptop/main/install.sh)
```

The script clones the repo to `~/nixos-config`, generates this machine's hardware config, and runs `nixos-rebuild switch`. Reboot, log in at the greeter, and niri starts.

After that, rebuild with:

```sh
cd ~/nixos-config && sudo nixos-rebuild switch --flake .#laptop
```

## Layout

Every `.nix` file under `modules/` is a flake-parts module, loaded automatically. Each feature file defines a `flake.modules.nixos.<name>` module; the host picks the ones it wants.

```
modules/
  flake/flake-parts.nix          systems + enables flake.modules
  hosts/laptop/configuration.nix composes the laptop from features
  hosts/laptop/_hardware-configuration.nix  generated (the "_" means import-tree skips it)
  nixos/base.nix                 boot, network, locale, sound, nix settings
  nixos/user.nix                 user account
  nixos/plymouth.nix             boot splash, themed LUKS prompt, silent boot
  desktop/niri.nix               niri, greetd login, fuzzel, fonts
  apps/kitty.nix                 kitty
```

To add a feature, create a new file that sets `flake.modules.nixos.<name>`, then add `features.<name>` to the host's list.

## After first login

- Change the password: `passwd` (initial password is `changeme`).
- niri writes its default config to `~/.config/niri/config.kdl` on first start. Its terminal bind (Mod+T) spawns `alacritty`; change that to `kitty`.
