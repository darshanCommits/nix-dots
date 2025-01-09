{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    chaotic.url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";

    stylix.url = "github:danth/stylix";

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?ref=refs/tags/v0.46.2";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins?ref=refs/tags/v0.46.0";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-easymotion = {
      url = "github:zakk4223/hyprland-easymotion";
      inputs.hyprland.follows = "hyprland";
    };

    umu = {
      url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:darshanCommits/home-manager/9f95867ea7c606617864f0e3f37bee509ce704b6";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:helix-editor/helix?ref=refs/tags/25.01";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes" "pipe-operators"];
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://helix.cachix.org"
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Add this line
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };

  outputs = {
    # self,
    nixpkgs,
    stylix,
    home-manager,
    chaotic,
    # hyprland,
    ...
  } @ inputs: let
    HOME = "/home/greeed";
    wallpaper = "${HOME}/.dotfiles/assets/wallpapers/goatv3.jpg";
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      greeed-nix = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs wallpaper HOME;
        };
        modules = [
          ./configuration.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.greeed = import ./home.nix;
          }
          stylix.nixosModules.stylix
        ];
      };
    };
  };
}
