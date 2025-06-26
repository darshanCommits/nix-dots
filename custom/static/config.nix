{ ... }:
let
  username = "greeed";
in
{
  config = {
    home = "/home/${username}";
    wallpaper = ./../../assets/images/goatv3.jpg;
    colorscheme = ./../../assets/colorscheme.yaml;
    username = username;

    loopbackAddress = "127.0.0.1";
    ip = "192.168.165.229";

    localDomain = "local";
    localhost = "0.0.0.0";
  };
}
