{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;

      # Login screen that starts a niri session
      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite # X11 app support
        brightnessctl   # brightness keys
      ];

      fonts.packages = with pkgs; [
        noto-fonts
        nerd-fonts.jetbrains-mono
      ];
    };
}
