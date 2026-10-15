{
  flake.modules.nixos.kitty =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.kitty ];
    };
}
