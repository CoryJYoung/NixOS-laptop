{
  description = "NixOS laptop — dendritic flake (flake-parts + import-tree)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";

    # Claude Code
    claude-code.url = "github:sadjow/claude-code-nix";

    # Homelab: SSH client entries for the lab instances, generated from its
    # instance map (modules/apps/homelab-ssh.nix). The repo is private; git
    # fetches it over HTTPS with the gh credential helper (github-cli.nix).
    # The follows lines reuse this flake's copies instead of locking second ones.
    homelab = {
      url = "git+https://github.com/CoryJYoung/homelab";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.import-tree.follows = "import-tree";
    };

  };

  # Dendritic pattern: every .nix file under ./modules is a flake-parts module.
  # Files or folders whose name starts with "_" are skipped by import-tree.
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
