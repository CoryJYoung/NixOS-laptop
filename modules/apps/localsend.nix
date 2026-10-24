{
  flake.modules.nixos.localsend = {
    programs.localsend = {
      enable = true;
      openFirewall = true; # opens port 53317 (TCP+UDP) so other devices can find the laptop
    };
  };
}
