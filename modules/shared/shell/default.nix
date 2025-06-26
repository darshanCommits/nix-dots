{ lib, pkgs, ... }:
let
  inherit (lib) mapAttrs;

  prefix = prefixStr: mapAttrs (_: v: "${prefixStr} ${v}");

  lsAliases = prefix "eza" {
    ls = "--color=always --group-directories-first --icons";
    ll = "-la --icons --octal-permissions --group-directories-first";
    l = "-bGF --header --git --color=always --group-directories-first --icons";
    llm = "-lbGd --header --git --sort=modified --color=always --group-directories-first --icons";
    la = "--long --all --group --group-directories-first";
    lx = "-lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons";
    lS = "-1 --color=always --group-directories-first --icons";
    lr = "--tree --level=2 --color=always --group-directories-first --icons";
  };

  gitAliases = prefix "git" {
    ga = "add";
    gcl = "clone";
    gca = "commit --amend";
    gcm = "commit -m";
    gb = "branch";
    gc = "checkout";
  };
in
{
  imports = [
    ./atuin
    ./fish
  ];

  environment.shells = with pkgs; [ fish bash ];
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    BROWSER = "zen";
    TERMINAL = "footclient";
    VIDEO_PLAYER = "mpv";
    AUDIO_PLAYER = "mpv";
    DIRENV_LOG_FORMAT = "";
  };
  environment.shellAliases = gitAliases // lsAliases // {
    rg = "rga";
    pdf = "zathura";
    btm = "btm --battery --enable_gpu --tree --expanded";
  };
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    carapace
    atuin
    nushell
    fzf
  ];
}
