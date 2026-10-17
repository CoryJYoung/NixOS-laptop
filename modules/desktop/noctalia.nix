{
  flake.modules.nixos.noctalia =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.noctalia-shell ];

      # Battery and power-mode widgets
      services.upower.enable = true;
      services.power-profiles-daemon.enable = true;

      # Enable networking and bluetooth
      networking.networkmanager.enable = true;
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true; # Optional: powers up BT on boot

    };
}
