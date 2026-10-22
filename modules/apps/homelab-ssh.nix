{ inputs, ... }:
{
  # `ssh dns01` (or its IP) logs in to a homelab instance on the lab's SSH
  # port. The names, IPs and port come from the homelab repo, so they are
  # never typed twice; `nix flake update homelab` picks up new instances.
  flake.modules.nixos.homelab-ssh = {
    imports = [ inputs.homelab.modules.nixos.ssh-client ];
  };
}
