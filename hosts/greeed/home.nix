# TODO: Need to refactor once i own another device (and thus reason to do so)
# currently its doing things awkwardly with the specialArgs and system.
{
  self,
  config,
  inputs,
  ...
}: let
  specialArgs = {
    inherit inputs self;
  };
in {
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
