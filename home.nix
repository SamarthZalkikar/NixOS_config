{
  config,
  pkgs,
  ...
}: {
  home.username = "samarth";
  home.homeDirectory = "/home/samarth";
  home.stateVersion = "25.11";

  services.swayidle = let
    myLockArgs = "-i /home/samarth/Pictures/wallpapers/Graphite_Mono/wallhaven-w55x2q.png";
    lockCmd = "${pkgs.swaylock}/bin/swaylock --daemonize -i /home/samarth/Pictures/wallpapers/Graphite_Mono/wallhaven-w55x2q.png";
    sleepLockCmd = "${pkgs.swaylock}/bin/swaylock -i /home/samarth/Pictures/wallpapers/Graphite_Mono/wallhaven-w55x2q.png";
    display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
  in {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }
      {
        timeout = 310;
        command = lockCmd;
      }
      {
        timeout = 330;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 900;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${sleepLockCmd} & sleep 1";
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = lockCmd;
      }
      {
        event = "unlock";
        command = display "on";
      }
    ];
  };

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
    userName = "youruser";
    userEmail = "yourmail";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      credential.helper = "store";
    };
  };

  home.packages = [
    (pkgs.papirus-icon-theme.override {
      color = "magenta";
    })
  ];
}
