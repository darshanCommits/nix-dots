{
  description = "My first flake!";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    stylix.url = "github:danth/stylix/release-24.11";
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hypridle.url = "github:hyprwm/hypridle";

    hyprland.url = "github:hyprwm/Hyprland/refs/tags/v0.48.0";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    pyprland.url = "github:hyprland-community/pyprland";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:darshanCommits/home-manager/9f95867ea7c606617864f0e3f37bee509ce704b6";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-forked = {
      url = "github:the-mikedavis/helix/driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    # self,
    nixpkgs,
    stylix,
    home-manager,
    chaotic,
    nixpkgs-unstable,
    nix-flatpak,
    rust-overlay,
    # hyprland,
    ...
  } @ inputs: let
    HOME = "/home/greeed";
    wallpaper = "${HOME}/.dotfiles/assets/wallpapers/goatv3.jpg";
    system = "x86_64-linux";
    overlays = import ./overlays {inherit inputs;};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          # inherit inputs wallpaper HOME chaotic;
          inherit
            inputs
            wallpaper
            HOME
            system
            # chaotic
            ;
        };

        modules = [
          ./configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          {
            nixpkgs.overlays = [
              overlays.default
              rust-overlay.overlays.default
              inputs.hyprpanel.overlay
            ];
          }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.greeed = {...}: {
                # nixpkgs.overlays = [
                #   inputs.hyprpanel.overlay
                # ];
                imports = [
                  ./home.nix
                ];
              };
            };
          }

          # chaotic stuff
          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry
        ];
      };
    };
  };
}
