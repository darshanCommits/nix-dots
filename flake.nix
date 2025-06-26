{
  description = "Yo yo yo. 148-3 to the 3 to the 6 to the 9, representing Darshan's dotfiles, what up biatch?!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:danth/stylix/release-25.05";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-driver = {
      url = "github:darshanCommits/helix/driver-new";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, stylix, home-manager, nix-flatpak, chaotic, ... } @ inputs:
    let
      system = "x86_64-linux";
      HOME = "/home/greeed";
      wallpaper = "${HOME}/.dotfiles/assets/wallpapers/goatv3.jpg";

      specialArgs = {
        inherit inputs wallpaper HOME system;
      };

      overlays = import ./overlays { inherit inputs; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;

        modules = [
          ./hardware-configuration.nix
          ./modules
          ./custom

          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak

          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry

          {
            nixpkgs.overlays = [ overlays.default ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;

              users.greeed.imports = [ ./home ];
            };
          }
        ];
      };
    };

}
