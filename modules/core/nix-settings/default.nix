{
  config,
  inputs,
  ...
}: {
  imports = [
    ./substituters.nix
    # inputs.lix.nixosModules.default
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      trusted-users = ["root" "@wheel" config.username];
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      max-jobs = "auto";
    };
  };
}
