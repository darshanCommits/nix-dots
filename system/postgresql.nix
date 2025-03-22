{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    enableJIT = true;
    package = pkgs.postgresql_17_jit;
  };
}
