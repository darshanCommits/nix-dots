{ inputs, config, pkgs, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./../common/base

    ./home.nix
    ./hardware-configuration.nix
    ./thermals

    ./../common/intel
    ./../common/nvidia
    ./../../modules
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelModules = [ "thinkpad_acpi" ];
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
