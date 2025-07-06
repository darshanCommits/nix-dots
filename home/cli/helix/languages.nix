{
  config,
  pkgs,
  ...
}: {
  programs.helix.languages.language-server = {
    rust-analyzer.config = {
      check.command = "clippy";
      cargo.features = "all";
    };

    biome = {
      command = "${pkgs.biome}/bin/biome";
      args = ["lsp-proxy"];
    };

    qmlls = {
      command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
      args = ["-E"];
    };

    emmet = {
      command = "${pkgs.emmet-language-server}/bin/emmet-language-server";
      args = ["--stdio"];
    };

    nixd = {
      command = "${pkgs.nixd}/bin/nixd";
      nixpkgs.expr = ''import (builtins.getFlake "${config.homeDir}/dotfiles").inputs.nixpkgs { }'';
      options.nixos.expr = ''(builtins.getFlake "${config.homeDir}/dotfiles").nixosConfigurations.greeed.options'';
      formatting.command = ["${pkgs.alejandra}/bin/alejandra"];
      nix.flake = {
        autoArchive = true;
        autoEvalInputs = true;
      };
    };

    shellcheck = {
      command = "${pkgs.shellcheck}/bin/shellcheck";
      args = ["-"];
    };

    tailwindcss-ls = {
      command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
      args = ["--stdio"];
    };
  };

  programs.helix.languages.language = [
    {
      name = "css";
      language-servers = ["vscode-css-language-server" "tailwindcss-ls"];
      auto-format = true;
    }

    {
      name = "javascript";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = ["format"];
        }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "typescript";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = ["format"];
        }
        "biome"
      ];
      auto-format = true;
    }

    {
      name = "html";
      language-servers = ["vscode-html-language-server" "tailwindcss-ls" "emmet"];
      auto-format = true;
    }

    {
      name = "tsx";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = ["format"];
        }
        "biome"
        "tailwindcss-ls"
        "emmet"
      ];
      auto-format = true;
    }

    {
      name = "jsx";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = ["format"];
        }
        "biome"
        "tailwindcss-ls"
        "emmet"
      ];
      auto-format = true;
    }

    {
      name = "json";
      language-servers = [
        {
          name = "vscode-json-language-server";
          except-features = ["format"];
        }
        "biome"
      ];
    }

    {
      name = "nix";
      language-servers = [
        {
          name = "nixd";
        }
      ];

      formatter.command = "${pkgs.alejandra}/bin/alejandra";
      auto-format = true;
    }

    {
      name = "rust";
      auto-format = true;
    }
  ];
}
