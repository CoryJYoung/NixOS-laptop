{
  # What the niri + Noctalia dotfiles (~/.config) expect to find
  flake.modules.nixos.noctalia-rice =
    { pkgs, ... }:
    {
      # Ghostty runs fish; the login shell stays bash
      programs.fish.enable = true;

      environment.systemPackages = with pkgs; [
        fastfetch
        cava
        btop
      ];

      fonts.packages = with pkgs; [
        lexend
        unifont
        maple-mono.truetype
      ];
    };
}
