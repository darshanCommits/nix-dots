{ ... }:
let
  quantum = 256;
  minQuantum = 64;
  maxQuantum = 512;
  clockRate = 48000;
  fracString = num: denom: "${toString num}/${toString denom}";
in
{
  # make pipewire realtime-capable
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    wireplumber.enable = true;

    extraConfig = {
      pipewire = {
        "context.modules" = [
          {
            name = "libpipewire-module-null-audio-sink";
            args = {
              node.name = "VirtualSink";
              node.description = "Virtual Sink for AudioRelay";
            };
          }
        ];
        "90-networking" = {
          "context.modules" = [
            {
              name = "libpipewire-module-zeroconf-discover";
              args = {
                "pulse.latency" = 500;
              };
            }
          ];
        };
        "92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = clockRate;
            # "default.clock.quantum" = quantum;
            # "default.clock.min-quantum" = minQuantum;
            # "default.clock.max-quantum" = maxQuantum;
          };
        };
      };

      pipewire-pulse."92-low-latency" = {
        "pulse.properties" = {
          "pulse.default.req" = fracString quantum clockRate;
          # "pulse.min.req" = fracString minQuantum clockRate;
          # "pulse.max.req" = fracString maxQuantum clockRate;
          # "pulse.min.quantum" = fracString minQuantum clockRate;
          # "pulse.max.quantum" = fracString maxQuantum clockRate;
        };
        "stream.properties" = {
          "node.latency" = fracString minQuantum clockRate;
          "resample.quality" = 8;
        };
      };
    };
  };
}
