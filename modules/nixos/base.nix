{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      nixpkgs.hostPlatform = "x86_64-linux";
      nixpkgs.config.allowUnfree = true;

      nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
      };

      # UEFI + systemd-boot
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.networkmanager.enable = true;

      time.timeZone = "Europe/Oslo";
      i18n.defaultLocale = "en_US.UTF-8";

      # Sound
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };

      environment.systemPackages = with pkgs; [
        git
        curl
        vim
      ];

      # Set this to the NixOS release you first installed with, then never change it.
      system.stateVersion = "26.05";
    };
}
