{ config
, inputs
, ...
}: {
  imports = [
    ./substituters.nix
    inputs.determinate.nixosModules.default
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      trusted-users = [ "root" "@wheel" config.username ];
      experimental-features = [ "nix-command" "flakes" ];
      lazy-trees = true;
      warn-dirty = false;
    };
  };
}
