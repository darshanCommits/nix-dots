{ ... }:
let
  # mkSubsituter = substituter: key: {
  #   subs
  # };
in
{
  nix.settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;

    substituters = [
      # Official
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"

      # 3rd Party
      "https://helix.cachix.org"
      "https://hyprland.cachix.org"
      "https://yazi.cachix.org"

      # Community
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://chaotic-nyx.cachix.org"

      "https://darshancommits.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="

      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="

      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="

      "darshancommits.cachix.org-1:aITLC4uLnoX/hHdms6Jfj60BkH9e21DxGPz/IB0YMvw="
    ];
  };
}
