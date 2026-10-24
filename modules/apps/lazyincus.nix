# lazyincus — lazydocker-style terminal UI for Incus.
# https://github.com/tallica/lazyincus
#
# Not in nixpkgs, so the package is built here (perSystem) and the feature
# module installs it. Socket access comes from incus.nix (incus-admin group),
# and the `incus` CLI it shells out to comes from virtualisation.incus.
{ withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.lazyincus = pkgs.buildGo127Module rec {
        pname = "lazyincus";
        version = "0.16.1";

        src = pkgs.fetchFromGitHub {
          owner = "tallica";
          repo = "lazyincus";
          tag = "v${version}";
          hash = "sha256-ESPsktS4jt2QTE5uawpUP51EJKJxubYJZ8buwDu+15k=";
        };

        # First build fails and prints the real hash: paste the "got:" value here.
        vendorHash = pkgs.lib.fakeHash;

        env.CGO_ENABLED = 0;
        ldflags = [
          "-s"
          "-w"
          "-X main.version=${version}"
          "-X main.buildSource=nix"
        ];

        # Tests want a live incusd; skip them in the sandbox.
        doCheck = false;

        meta = {
          description = "Terminal UI for Incus";
          homepage = "https://github.com/tallica/lazyincus";
          license = pkgs.lib.licenses.mit;
          mainProgram = "lazyincus";
        };
      };
    };

  flake.modules.nixos.lazyincus =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (withSystem pkgs.stdenv.hostPlatform.system ({ config, ... }: config.packages.lazyincus))
        # Uncomment for the Stacks/Services panels (incus-compose on PATH):
        # pkgs.incus-compose
      ];

      environment.shellAliases.lzi = "lazyincus";
    };
}
