{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "${config.homeDir}/.config/sops/age/keys.txt";

  sops.secrets."LastFM.ApiKey" = {};
  sops.secrets."LastFM.Secret" = {};
}
