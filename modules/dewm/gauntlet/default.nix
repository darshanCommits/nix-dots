{inputs, ...}: {
  imports = [inputs.gauntlet.nixosModules.default];
  programs.gauntlet = {
    enable = true;
    service.enable = true;
  };
}
