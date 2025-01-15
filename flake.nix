{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    stylix.url = "github:danth/stylix/release-24.11";

    # TODO:1 need to investigate, cant figure out this
    # inputs.gauntlet.url = github:project-gauntlet/gauntlet/dbc22aa81b1afce91efb869f0df9ccbff7b6cd6a;
    # gauntlet = {
    #   url = "github:project-gauntlet/gauntlet/dbc22aa81b1afce91efb869f0df9ccbff7b6cd6a";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?ref=refs/tags/v0.46.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyprland = {
      url = "github:hyprland-community/pyprland?ref=refs/tags/2.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
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
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs wallpaper HOME chaotic;
        };
        modules = [
          ./configuration.nix
          stylix.nixosModules.stylix
          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.greeed = import ./home.nix;
          }
        ];
      };
    };
  };
}
