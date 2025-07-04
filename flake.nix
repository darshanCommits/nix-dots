{
  description = "Yo yo yo. 148-3 to the 3 to the 6 to the 9, representing Darshan's dotfiles, what up biatch?!";

  outputs = { nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";
      forAllSystems = nixpkgs.lib.genAttrs [ system ];

      mkNixOsConfig = host: {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/${host}
        ];
      };
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
      nixosConfigurations = {
        greeed = nixpkgs.lib.nixosSystem (mkNixOsConfig "greeed");
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # I can do this because i am only taking the cachyos kernel from chaotic. it might break if i do anythig more.
    # it will lower the time to evaluate inputs
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        home-manager.follows = "home-manager";
        rust-overlay.follows = "rust-overlay";
        # nixpkgs.follows = "nixpkgs-unstable"; # might need to delete this. yep. had to. 
      };
    };

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:danth/stylix/release-25.05";

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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };
  };
}
