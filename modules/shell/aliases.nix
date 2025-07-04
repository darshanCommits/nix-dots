{ lib, ... }:
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
    lr = "--tree --level=1 --color=always --group-directories-first --icons";
    lR = "--tree --color=always --group-directories-first --icons";
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
  environment.shellAliases = gitAliases // lsAliases // {
    rg = "rga";
    pdf = "zathura";
    btm = "btm --battery --enable_gpu --tree --expanded";
    heroic = "heroic --enable-features=WaylandWindowDecorations --enable-features=UseOzonePlatform --ozone-platform=wayland";
    brave = "brave --enable-features=TouchpadOverscrollHistoryNavigation,UseOzonePlatform --ozone-platform=wayland";
  };
}

