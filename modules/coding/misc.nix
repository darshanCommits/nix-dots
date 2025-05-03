{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mold-wrapped
    sccache
    cachix
    devenv
  ];
}
