{ ... }:
{
  imports = [
    ./languages.nix
  ];
  programs.helix = {
    enable = true;
    theme = "glazor";
  };

  programs.helix.settings.editor = {
    soft-wrap.enable = true;
    completion-trigger-len = 1;
    line-number = "relative";
    color-modes = true;
    mouse = false;
    shell = [ "sh" "-c" ];
    popup-border = "all";
    rainbow-brackets = true;

    bufferline = {
      show = "always";
      context = "minimal";
    };

    word-completion = {
      enable = true;
      trigger-length = 3;
    };

    auto-save = {
      focus-lost = true;
      after-delay.enable = true;
    };

    inline-diagnostics = {
      cursor-line = "hint";
      other-lines = "disable";
    };

    lsp = {
      display-messages = true;
      display-inlay-hints = true;
    };

    indent-guides = {
      render = true;
      character = "│";
      # separator = "┊"; # uncomment if needed
    };

    cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };

    statusline = {
      left = [ "mode" "spinner" "total-line-numbers" "file-encoding" ];
      center = [ "diagnostics" "workspace-diagnostics" ];
      right = [
        "position"
        "position-percentage"
        "spacer"
        "separator"
        "spacer"
        "version-control"
      ];
    };
  };

  programs.helix.settings.keys.normal = {
    "esc" = ":update";
    "C-a" = "@<A-a>";
    "ret" = "@]<space>j";
    "C-ret" = "@[<space>k";
    "X" = "extend_line_above";
    "Z" = ":wa";
    "home" = "increment";
    "C-backspace" = "@<space>w";
    "H" = "move_prev_sub_word_start";
    "L" = "move_next_sub_word_end";
    "C-g" = [
      ":write-all"
      ":new"
      ":insert-output lazygit"
      ":buffer-close!"
      ":redraw"
      ":reload-all"
    ];

    space = {
      "q" = ":q";

      e = [
        ":sh rm -f /tmp/unique-file"
        ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
        ":insert-output echo \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
        ":open %sh{cat /tmp/unique-file}"
        ":redraw"
      ];

      E = [
        ":sh rm -f /tmp/unique-file"
        ":insert-output yazi --chooser-file=/tmp/unique-file"
        ":insert-output echo \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
        ":open %sh{cat /tmp/unique-file}"
        ":redraw"
      ];
    };
  };

  programs.helix.settings.keys.select = {
    "X" = "extend_line_above";
  };

  programs.helix.settings.keys.insert = {
    "C-left" = "@<esc>b;i";
    "C-right" = "@<esc>el;i";
    "home" = "@<esc>ghi";
    "end" = "@<esc>glli";
    "C-k" = "@<esc>t<ret>di";
    "C-u" = "@<esc>T<ret>di";
    "C-backspace" = "@<esc>bdi";
    "C-del" = "delete_word_forward";
  };
}
