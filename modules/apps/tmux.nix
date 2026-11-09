{
  flake.modules.nixos.tmux = {
    programs.tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      historyLimit = 10000;
      escapeTime = 0; # no lag after Esc in vim/helix
      terminal = "tmux-256color";
      extraConfig = ''
        set -g mouse on
        set -g base-index 1
        setw -g pane-base-index 1
        set -g renumber-windows on
        set -as terminal-features ",xterm-ghostty:RGB"
      '';
    };
  };
}
