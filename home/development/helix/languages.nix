{ pkgs, ... }: {
  programs.helix.languages.language-server = {
    rust-analyzer.config = {
      check.command = "clippy";
      cargo.features = "all";
    };

    biome = {
      command = "${pkgs.biome}/bin/biome";
      args = [ "lsp-proxy" ];
    };

    emmet = {
      command = "${pkgs.nodePackages.emmet-ls}/bin/emmet-ls"; # adjust if package name differs
      args = [ "--stdio" ];
    };

    nixd = {
      command = "${pkgs.nixd}/bin/nixd";
      args = [ "--inlay-hints" "--semantic-tokens" ];
      config.nixd.options.home-manager.expr =
        ''(builtins.getFlake "/home/greeed/dotfiles").homeConfigurations."nixos".options'';
    };

    shellcheck = {
      command = "${pkgs.shellcheck}/bin/shellcheck";
      args = [ "-" ];
    };

    typescript-language-server = {
      command = "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server";
      args = [
        "--stdio"
        "--tsserver-path=${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib"
      ];
    };

    vscode-css-language-server = {
      command = "${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver";
      args = [ "--stdio" ];
    };

    vscode-html-language-server = {
      command = "${pkgs.nodePackages.vscode-html-languageserver-bin}/bin/html-languageserver";
      args = [ "--stdio" ];
    };

    vscode-json-language-server = {
      command = "${pkgs.nodePackages.vscode-json-languageserver}/bin/json-languageserver";
      args = [ "--stdio" ];
    };

    tailwindcss-ls = {
      command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
      args = [ "--stdio" ];
    };
  };

  programs.helix.languages.language = [
    {
      name = "css";
      language-servers = [ "vscode-css-language-server" "tailwindcss-ls" ];
      auto-format = true;
    }

    {
      name = "javascript";
      language-servers = [
        { name = "typescript-language-server"; except-features = [ "format" ]; }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "typescript";
      language-servers = [
        { name = "typescript-language-server"; except-features = [ "format" ]; }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "html";
      language-servers = [ "vscode-html-language-server" "tailwindcss-ls" "emmet" ];
      auto-format = true;
    }

    {
      name = "tsx";
      language-servers = [
        { name = "typescript-language-server"; except-features = [ "format" ]; }
        "biome"
        "tailwindcss-ls"
        "emmet"
      ];
      auto-format = true;
    }

    {
      name = "jsx";
      language-servers = [
        { name = "typescript-language-server"; except-features = [ "format" ]; }
        "biome"
        "tailwindcss-ls"
        "emmet"
      ];
      auto-format = true;
    }

    {
      name = "json";
      language-servers = [
        { name = "vscode-json-language-server"; except-features = [ "format" ]; }
        "biome"
      ];
    }

    {
      name = "nix";
      formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
      auto-format = true;
    }

    {
      name = "rust";
      auto-format = false;
    }
  ];
}
