{
  description = "Yo yo yo. 148-3 to the 3 to the 6 to the 9, representing Darshan's dotfiles, what up biatch?!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # I can do this because i am only taking the cachyos kernel from chaotic. it might break if i do anythig more.
    # it will lower the time to evaluate inputs
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        home-manager.follows = "";
        rust-overlay.follows = "";
        jovian.follows = "";
        flake-schemas.follows = "";
      };
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-25.05";

    fenix = {
      url = "github:nix-community/fenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-analyzer-src.follows = ""; # comment if i want to use nightly
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-driver = {
      url = "github:darshanCommits/helix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    forAllSystems = nixpkgs.lib.genAttrs [system];

    mkNixOsConfig = host: {
      inherit system;
      specialArgs = {
        inherit inputs self;
      };
      modules = [
        ./lib
        ./hosts/${host}
        {
          nixpkgs.overlays = [
            (import ./overlays inputs.nixpkgs-unstable)
          ];
        }
      ];
    };
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    nixosConfigurations = {
      greeed = nixpkgs.lib.nixosSystem (mkNixOsConfig "greeed");
    };
  };
}
