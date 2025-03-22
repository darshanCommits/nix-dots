{
  # HOME,
  pkgs,
  ...
}: {
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.groups.libvirtd.members = ["greeed"];
  users.users.greeed.extraGroups = ["libvirtd"];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    xorg.xf86videoqxl
    virtiofsd
  ];

  networking.firewall = {
    trustedInterfaces = ["virbr0"];
    allowedTCPPortRanges = [
      # spice
      {
        from = 5900;
        to = 5999;
      }
    ];
    allowedTCPPorts = [
      # libvirt
      16509
    ];
  };
}
