{ pkgs
, inputs
, ...
}:
let zen =
  inputs.zen-browser.packages."${pkgs.system}".twilight
; in

{
  environment.systemPackages = with pkgs; [
    brave
    zen
  ];
}
