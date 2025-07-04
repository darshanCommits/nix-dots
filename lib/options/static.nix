# YOU MUST FIRST DEFINE THE CONFIG OPTIONS IN THE ./types.nix
{ config, ... }:
let
  username = "greeed";
  assets = ./../../assets;
in
{
  config = {
    wallpaper = ./../../assets/images/goatv3.jpg;
    colorscheme = ./../../assets/colorscheme.yaml;
    username = username;

    loopbackAddress = "127.0.0.1";
    ip = "192.168.165.229";

    homeDir = "/home/${username}";
    currentCompositor = "hyprland";
    localDomain = "local";
    localhost = "0.0.0.0";

    ghUserName = "darshanCommits";
    email = "kumawatdarshan.1304@gmail.com";
  };
}
