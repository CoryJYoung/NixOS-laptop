{ inputs, config, ... }:
let
  # All NixOS feature modules defined anywhere under ./modules
  features = config.flake.modules.nixos;
in
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      features.base
      features.plymouth
      features.user
      features.niri
      features.firefox
      features.onepassword
      features.vscode
      features.noctalia
      features.ghostty
      features.gnome-keyring
      features.incus
      features.lazyincus
      features.claude-code
      features.opentofu
      features.github-cli
      features.files
      features.media
      features.ssh
      features.homelab-ssh
      features.localsend
      # Generated on the laptop by install.sh (the "_" keeps import-tree from loading it)
      ./_hardware-configuration.nix

      { networking.hostName = "laptop"; }
    ];
  };
}
