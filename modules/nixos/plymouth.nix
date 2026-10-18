{
  # Graphical boot splash with a themed LUKS password prompt, plus a quiet boot.
  flake.modules.nixos.plymouth =
    { ... }:
    {
      boot = {
        plymouth = {
          enable = true;
          # Vendor (firmware) logo with a spinner and a clean password field.
          # For something fancier, use the adi1090x themes, e.g.:
          #   theme = "rings";
          #   themePackages = [
          #     (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "rings" ]; })
          #   ];
          theme = "bgrt";
        };

        # systemd in the initrd hands the LUKS prompt to Plymouth cleanly.
        initrd.systemd.enable = true;

        # Load the Intel GPU driver early so the splash shows immediately
        # at native resolution.
        initrd.kernelModules = [ "i915" ];

        # Silent boot: hide kernel and systemd messages behind the splash.
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];

        # Skip the systemd-boot menu; hold Space during boot to show it.
        loader.timeout = 0;
      };

      # Apply the console keymap (Norwegian, from base.nix) in the initrd
      # so æ/ø/å work when typing the passphrase.
      console.earlySetup = true;
    };
}
