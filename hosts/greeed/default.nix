{ ... }: {
  imports = [
    ./hardware-configuration.nix

    ./intel
    ./kernel
    ./lenovo-loq
    ./nvidia
    ./thermals
    ./../../modules
  ];

  users = {
    users.greeed = {
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
