{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      ports = [ 9526 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
  	PermitRootLogin = "no";
	AllowUsers = [ "cory" ];
      };
    };

    users.users.cory.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALfS6e59mxrSXuGo2NYQwvGKeusazjOmnyytbbiaouS"
    ];

    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };
}


