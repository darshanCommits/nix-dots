{inputs, ...}: {
  imports = [
    ./secrets.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];
}
