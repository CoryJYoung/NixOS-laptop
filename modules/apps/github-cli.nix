{
  flake.modules.nixos.github-cli = 
    { pkgs, ... }:
  {
    environment.systemPackages = [ pkgs.github-cli ];
  };
}
