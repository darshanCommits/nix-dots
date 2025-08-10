inputs: final: prev: {
  feeluown = final.callPackage ../pkgs/feeluown {
    pythonPackages = final.python3.pkgs;
  };
}
