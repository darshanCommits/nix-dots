{...}: {
  programs.adb.enable = true;
  users.users.greeed.extraGroups = ["adbusers"];
}
