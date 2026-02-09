{ config, pkgs, ... }:

{
  home.username = "samarth";
  home.homeDirectory = "/home/samarth";
  home.stateVersion = "25.11"; 

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Samarth";
    userEmail = "zalkikarsamarth898@.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      credential.helper = "store";
     };
  };
}
