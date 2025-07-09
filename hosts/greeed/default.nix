{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ./../common/base

    ./home.nix
    ./hardware-configuration.nix
    ./thermals

    ./../common/intel
    ./../common/nvidia
    ./../../modules
  ];

  services.openssh.enable = true;

  # i mostly use tldr
  documentation = {
    enable = false;
    doc.enable = false;
    dev.enable = false;
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelModules = ["thinkpad_acpi"];
    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';
  };

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  users = {
    users.${config.username} = {
      isNormalUser = true;
      description = "Darshan Kumawat";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
        "input"
        "gamemode"
      ];
    };
  };
}
