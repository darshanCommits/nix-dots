{
  config,
  inputs,
  ...
}: {
  imports = [
    ./substituters.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      trusted-users = ["root" "@wheel" config.username];
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
