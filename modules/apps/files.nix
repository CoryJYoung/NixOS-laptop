{
  flake.modules.nixos.files =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nautilus
        yazi # optional: fast file manager inside the terminal
      ];

      # Trash, USB drives, phones, network shares (smb://, sftp://) in Nautilus
      services.gvfs.enable = true;

      # Make Nautilus the default for "open folder"
      xdg.mime.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
    };
}

