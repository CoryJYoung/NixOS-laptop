{
  flake.modules.nixos.incus = {
    virtualisation.incus = {
      enable = true;
      ui.enable = true; # web UI at https://localhost:8443 (optional)

      # First-time setup that `incus admin init` would otherwise ask about
      preseed = {
        networks = [
          {
            name = "incusbr0";
            type = "bridge";
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat" = "true";
              "ipv6.address" = "none";
            };
          }
        ];
        storage_pools = [
          {
            name = "default";
            driver = "dir";
            config.source = "/var/lib/incus/storage-pools/default";
          }
        ];
        profiles = [
          {
            name = "default";
            devices = {
              eth0 = {
                name = "eth0";
                network = "incusbr0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                type = "disk";
              };
            };
          }
        ];
      };
    };

    # Incus on NixOS requires nftables
    networking.nftables.enable = true;

    # Let containers/VMs get IP addresses and reach the internet
    networking.firewall.trustedInterfaces = [ "incusbr0" ];

    # Use incus without sudo
    users.users.cory.extraGroups = [ "incus-admin" ];
  };
}
