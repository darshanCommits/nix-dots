{...}: let
  username = "greeed";
in {
  config = {
    home = "/home/${username}";
    wallpaper = ./../../assets/images/goatv3.jpg;
    colorscheme = ./../../assets/colorscheme.yaml;
    username = username;

    localDomain = "local";
    loopbackAddress = "127.0.0.1";
    ip = "192.168.0.120";
    localhost = "0.0.0.0";
  };
}
