{inputs, ...}: {
  imports = [inputs.gauntlet.nixosModules.default];

  programs.gauntlet = {
    enable = false;
    service.enable = true;
  };
}
