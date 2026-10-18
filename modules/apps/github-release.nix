{
  flake.modules.nixos.github-release = 
    { pkgs, ... }:
  {
    environment.systemPackages = [ pkgs.github-release ];
  };
}
