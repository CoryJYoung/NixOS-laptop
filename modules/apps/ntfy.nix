{
  # Desktop notifications from the homelab's ntfy server (push01, see the
  # homelab repo's nixos/monitoring/ntfy.nix). Server, login and topics are in
  # ~/.config/ntfy/client.yml, kept out of the repo because it holds the
  # password; the service does nothing until that file exists.
  flake.modules.nixos.ntfy-client =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.ntfy-sh ];

      systemd.user.services.ntfy-client = {
        description = "ntfy notifications from the homelab";
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        unitConfig.ConditionPathExists = "%h/.config/ntfy/client.yml";
        # ntfy runs each topic's command with sh; notify-send shows it in Noctalia
        path = [
          pkgs.bash
          pkgs.libnotify
        ];
        serviceConfig = {
          ExecStart = "${pkgs.ntfy-sh}/bin/ntfy subscribe --from-config";
          Restart = "on-failure";
          RestartSec = 10;
        };
      };
    };
}
