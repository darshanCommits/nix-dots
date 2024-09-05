{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    jq
    tealdeer
    bc
    dua
    fd
    eza
    nitch
    bottom
    bat
    zsh-completions
    ripgrep
    zoxide
    ripgrep-all
    yazi
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    # syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      lsv = "live-server";
      cat = "bat";
      # man = "batman";
      j = "z";
      cd = "z";
      img = "wezterm imgcat";
      anime = "ani-cli";
      "..." = "cd ../..";
      pdf = "zathura";

      ls = "eza -g --icons --header --group-directories-first";
      la = "eza -lag --icons --header --group-directories-first";
      lr = "eza -Tg -L 2 --icons --header --group-directories-first";
      lR = "eza -Tg --icons --header --group-directories-first";

      mkdir = "mkdir -pv";
      mount = "mount |column -t";

      # GIT
      ga = "git add .";
      gcm = "git commit -m";
      gca = "git commit --amend";
      push = "git push";
      gcl = "git clone";
    };
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
      save = 100000000;
      size = 1000000000;
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
    ];

    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "emacs";
      };
      pmodules = ["autosuggestions" "directory" "editor" "git" "terminal"];
    };

    initExtra = ''
      source <(nh completions --shell zsh)
      unsetopt BEEP
      setopt appendhistory
      setopt extendedhistory
      setopt histverify
      setopt interactivecomments
      zstyle ':completion:*:*:*:*:*' menu select

      # Complete . and .. special directories
      zstyle ':completion:*' special-dirs true

      zstyle ':completion:*' list-colors ""
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

      # disable named-directories autocompletion
      zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

      # Use caching so that commands like apt and dpkg complete are useable
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
      zstyle '*' single-ignored complete
      zstyle ':completion:*' completer _extensions _complete _approximate
      zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
      zstyle ':completion:*' squeeze-slashes true
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      bindkey -v
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^H'      backward-delete-word
      bindkey '^[[3~'   delete-char
      bindkey '^[w'     kill-word
      bindkey '^[[3;5~' kill-word
    '';
  };

  programs.starship.enable = true;
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      keymap_mode = "vim-normal";
      keymap_cursor = {
        vim_insert = "blink-bar";
        vim_normal = "steady-block";
      };
    };
  };

  programs.eza.enableZshIntegration = true;
  programs.fzf.enableZshIntegration = true;
  programs.yazi.enableZshIntegration = true;
  programs.zoxide.enableZshIntegration = true;
}
