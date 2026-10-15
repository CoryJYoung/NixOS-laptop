{
  flake.modules.nixos.user = {
    users.users.cory = {
      isNormalUser = true;
      description = "Cory";
      extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
      # Set a password after the first switch with: sudo passwd cory
      initialPassword = "changeme";
    };
  };
}
