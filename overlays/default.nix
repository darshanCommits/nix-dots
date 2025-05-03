{inputs, ...}: let
  unstable = import ./unstable.nix inputs.nixpkgs-unstable;
in {
  default = final: prev: unstable final prev;
}
