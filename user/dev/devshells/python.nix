# USE THIS LIKE ```nix develop <path>/python.nix or ```
{
  description = "Global Python Environment. ";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: {
    devShells.default = nixpkgs.lib.mkShell {
      buildInputs = [
        (nixpkgs.python3.withPackages (ps:
          with ps; [
            numpy
            pandas
            requests
            flask
            tensorflow
            matplotlib
          ]))
      ];
    };
  };
}
