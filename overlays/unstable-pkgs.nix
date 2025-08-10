nixpkgs-unstable: final: prev: {
  unstable = import nixpkgs-unstable {
    system = final.system;
    config.allowUnfree = true;
  };
}
