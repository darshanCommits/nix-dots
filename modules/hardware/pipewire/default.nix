{...}: let
  quantum = 128;
  minQuantum = 32;
  maxQuantum = 1024;
  clockRate = 48000;
  fracString = num: denom: "${toString num}/${toString denom}";
in {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;

    extraConfig = {
      pipewire."90-networking" = {
        "context.modules" = [
          {
            name = "libpipewire-module-zeroconf-discover";
            args = {
              "pulse.latency" = 500;
            };
          }
        ];
      };
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = clockRate;
          "default.clock.quantum" = quantum;
          "default.clock.min-quantum" = minQuantum;
          "default.clock.max-quantum" = maxQuantum;
        };
      };
      pipewire-pulse."92-low-latency" = {
        "pulse.properties" = {
          "pulse.min.req" = fracString minQuantum clockRate;
          "pulse.default.req" = fracString quantum clockRate;
          "pulse.max.req" = fracString maxQuantum clockRate;
          "pulse.min.quantum" = fracString minQuantum clockRate;
          "pulse.max.quantum" = fracString maxQuantum clockRate;
        };
        "stream.properties" = {
          "node.latency" = fracString minQuantum clockRate;
          "resample.quality" = 8;
        };
      };
    };
  };
}
