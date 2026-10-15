{
  description = "NixOS laptop — dendritic flake (flake-parts + import-tree)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";
  };

  # Dendritic pattern: every .nix file under ./modules is a flake-parts module.
  # Files or folders whose name starts with "_" are skipped by import-tree.
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
