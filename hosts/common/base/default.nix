{inputs, ...}: {
  nixpkgs.overlays = [
    (import ./../../../overlays inputs)
  ];

  imports = [
    ./../../../lib
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];
}
