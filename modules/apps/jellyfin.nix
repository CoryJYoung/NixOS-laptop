{
  flake.modules.nixos.jellyfin-clients =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        jellyfin-desktop # best codac jellyfin
        fladder # pretty jellyfin with Seerr intergration
      ];
    };
}