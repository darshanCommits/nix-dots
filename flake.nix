{
  description = "Yo yo yo. 148-3 to the 3 to the 6 to the 9, representing Darshan's dotfiles, what up biatch?!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:danth/stylix/release-24.11";

    # TODO: use the nixpkgs version once the helix fix lands in stable nixpkgs
    yazi.url = "github:sxyazi/yazi?ref=refs/tags/nightly";

    hyprland.url = "github:hyprwm/Hyprland/refs/tags/v0.48.1";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-driver = {
      url = "github:darshanCommits/helix/2e91eac0fccd8dccb9b7eae2f6aff985a779491f";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    gauntlet = {
      url = "github:project-gauntlet/gauntlet/v19";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    stylix,
    home-manager,
    nix-flatpak,
    gauntlet,
    ...
  } @ inputs: let
    HOME = "/home/greeed";
    wallpaper = "${HOME}/.dotfiles/assets/wallpapers/goatv3.jpg";
    system = "x86_64-linux";
    overlays = import ./overlays {inherit inputs;};
    specialArgs = {
      inherit
        inputs
        wallpaper
        HOME
        system
        ;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = specialArgs;
      modules = [
        ./hardware-configuration.nix
        ./modules
        ./custom
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
        gauntlet.overlays.default
        {
          nixpkgs.overlays = [
            overlays.default
          ];
          home-manager = {
            extraSpecialArgs = specialArgs;
            useGlobalPkgs = true;
            useUserPackages = true;
            users.greeed = {
              imports = [
                ./home
              ];
            };
          };
        }
      ];
    };
  };
}
