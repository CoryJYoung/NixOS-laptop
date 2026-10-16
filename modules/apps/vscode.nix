{
  flake.modules.nixos.vscode =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.vscode ];

      # Run VS Code (and other Electron apps) natively on Wayland/niri
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      # Lets extensions that download their own binaries (language servers, debuggers) run
      programs.nix-ld.enable = true;
    };
}
