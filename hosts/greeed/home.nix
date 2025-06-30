# TODO: Need to refactor once i own another device (and thus reason to do so)
# currently its doing things awkwardly with the specialArgs and system. 
{ config, inputs, ... }:
let
  system = "x86_64-linux";
  specialArgs = {
    inherit inputs system;
  };
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;

    # TODO: I am importing everything cause its a single system, in future i should import only what i need.
    users.${config.username}.imports = [
      ./../../home
      ./../../home/desktop/niri

    ];
  };

}
