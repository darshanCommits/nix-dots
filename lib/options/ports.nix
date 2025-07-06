{
  config,
  lib,
  ...
}: {
  config.port = {
    llmUi = 1234;
    immich = 2283;
    navidrome = 4533;
    nginx = 80;
    dnsmasq = 53;
  };

  config.assertions = [
    {
      assertion = let
        vals = lib.attrValues config.port;
        noCollision = l: lib.length (lib.unique l) == lib.length l;
      in
        noCollision vals;
      message = "port collision happened.";
    }
  ];
}
