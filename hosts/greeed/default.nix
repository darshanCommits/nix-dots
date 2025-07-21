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

    ./../common/intel
    ./../common/nvidia
    ./../../modules
  ];

  services.openssh.enable = true;
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;

  services.thermald.enable = true;
  services.undervolt = {
    enable = true;
    coreOffset = -125;
    turbo = 0;
  };
  services.auto-cpufreq = let
    Ghz = x: x * 1000 * 1000;
  in {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        energy_perf_bias = "performance";
        scaling_max_freq = Ghz 4.4;
        turbo = "auto";
      };
    };
  };

  # i mostly use tldr
  documentation = {
    enable = false;
    doc.enable = false;
    dev.enable = false;
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  # https://github.com/NixOS/nixpkgs/issues/211345#issuecomment-1397825573
  systemd.tmpfiles.rules =
    map
    (
      e: "w /sys/bus/${e}/power/control - - - - auto"
    ) [
      "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
      "pci/devices/0000:00:14.0" # FCH SMBus Controller
      "pci/devices/0000:00:14.3" # FCH LPC bridge
      "pci/devices/0000:04:00.0" # FCH SATA Controller [AHCI mode]
      "pci/devices/0000:04:00.1/ata1" # FCH SATA Controller, port 1
      "pci/devices/0000:04:00.1/ata2" # FCH SATA Controller, port 2
      "usb/devices/1-3" # USB camera
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    extraModulePackages = with config.boot.kernelPackages; [lenovo-legion-module];
    kernelModules = [
      "ntsync"
      "thinkpad_acpi"
      "v4l2loopback"
    ];
    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
      options v4l2loopback devices=1 video_nr=0 card_label="WebCam"
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
