# TODO: Need to refactor once i own another device (and thus reason to do so)
{ inputs, ... }:
let
  overlays = import ./../../../overlays {
    inherit inputs;
  };
in
{
  imports = [
    ./../../../lib
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];


  nixpkgs.overlays = [ overlays.default ];
}
