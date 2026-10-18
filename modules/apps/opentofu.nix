{
  flake.modules.nixos.opentofu =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.opentofu ];
    };
}
