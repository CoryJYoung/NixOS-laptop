{
  flake.modules.nixos.github-cli = 
    { pkgs, ... }:
  {
    environment.systemPackages = [ pkgs.github-cli ];

    programes.git = {
      enable = true;
      config.credential."https://github.com".helper = "!gh auth git-credential";
    };
  };
}
