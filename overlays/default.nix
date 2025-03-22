# overlays/default.nix
{inputs}: {
  # Export each overlay as a named attribute
  unstable = import ./unstable-overlay.nix inputs.nixpkgs-unstable;

  # You can add more overlays here
  # my-other-overlay = import ./other-overlay.nix;
  default = final: prev: let
    # Apply each overlay and merge the results
    unstable = (import ./unstable-overlay.nix inputs.nixpkgs-unstable) final prev;
    # otherResult = (import ./other-overlay.nix) final prev;
  in
    # Merge all the overlay results
    unstable; # // otherResult // etc.
}
