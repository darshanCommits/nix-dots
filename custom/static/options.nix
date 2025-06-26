{ lib, ... }:
with lib; {
  options = {
    wallpaper = mkOption {
      type = types.path;
      description = "Path to the wallpaper image.";
    };

    colorscheme = mkOption {
      type = types.path;
      description = "Path to the colorscheme file.";
    };

    home = mkOption {
      type = types.path;
      description = "Path to Home Directory";
    };

    username = mkOption {
      type = types.str;
      description = "Username to be used in the configuration.";
    };

    serve = mkOption {
      type = types.str;
      description = "Serve Adress";
    };

    ip = mkOption {
      type = types.str;
      description = "LAN IP Adress.";
    };

    localDomain = mkOption {
      type = types.str;
      description = "Local DNS name to use for reverse proxy (e.g., music.local).";
    };

    localhost = mkOption {
      type = types.str;
      default = "0.0.0.0";
      description = "Localhost address, typically 0.0.0.0";
    };

    loopbackAddress = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Loopback address, typically 127.0.0.1.";
    };

    port = mkOption {
      type = with types; attrsOf port;
      default = { };
    };

    serviceDomains = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            description = "Subdomain name for the service";
          };

          port = mkOption {
            type = types.int;
            description = "Port number the service is running on";
          };

          location = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "Optional URL path to proxy (defaults to '/')";
          };

          proxyPass = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = ''
              Optional proxy pass URL. Defaults to http://<localhost>:<port>
            '';
          };

          extraConfig = mkOption {
            type = types.nullOr types.lines;
            default = "proxy_set_header Host $host;";
            description = "Optional additional Nginx config for the location block.";
          };
        };
      });
      description = "List of local domain services to proxy via nginx.";
    };
  };
}
