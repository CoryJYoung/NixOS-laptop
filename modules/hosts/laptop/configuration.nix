{ inputs, config, ... }:
let
  # All NixOS feature modules defined anywhere under ./modules
  features = config.flake.modules.nixos;
in
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      features.base
      features.user
      features.niri
      features.kitty

      # Generated on the laptop by install.sh (the "_" keeps import-tree from loading it)
      ./_hardware-configuration.nix

      { networking.hostName = "laptop"; }
    ];
  };
}
