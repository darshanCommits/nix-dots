{
  pkgs,
  inputs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
