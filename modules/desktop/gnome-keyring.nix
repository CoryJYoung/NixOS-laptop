{
  flake.modules.nixos.gnome-keyring =
    { pkgs, ... }:
    {
      services.gnome.gnome-keyring.enable = true;

      # Unlock the keyring automatically when you log in at the greeter
      security.pam.services.greetd.enableGnomeKeyring = true;

      # Keep the keyring password in sync when you change yours with `passwd`
      security.pam.services.passwd.enableGnomeKeyring = true;

      environment.systemPackages = [
        pkgs.seahorse # GUI to view and manage stored secrets
        pkgs.libsecret # `secret-tool` for checking it works from the terminal
      ];
    };
}
