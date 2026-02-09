{
  config,
  lib,
  pkgs,
  ...
}: let
  custom-astronaut-theme = pkgs.stdenv.mkDerivation {
    name = "sddm-astronaut-theme";
    src = ./themes;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
      cp -r . $out/share/sddm/themes/sddm-astronaut-theme
    '';
  };
in let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
in {
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Home-manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.samarth = import ./home.nix;

  # unfree
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "thinkpad";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.

  i18n.defaultLocale = "en_US.UTF-8";

  # different formats for currency, dates, etc.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  console.useXkbConfig = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.samarth = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  # CUSTOM STUFF
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # Wayland stuff
  environment.sessionVariables = {
    ADW_DISABLE_PORTAL = "1";
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    grim
    slurp
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin
    xfce.thunar-archive-plugin
    xfce.thunar-vcs-plugin
    neovim
    wget
    qutebrowser
    mpv
    rofi
    rofi-emoji
    waybar
    foot
    kitty
    zip
    unzip
    swww
    swayimg
    zathura
    vesktop
    opencode
    docker
    git
    wl-clipboard
    swaylock
    adwaita-icon-theme
    swayidle
    typst
    tmux
    papirus-icon-theme
    gruvbox-dark-gtk
    libreoffice-fresh
    nwg-look
    obsidian
    lua
    antigravity
    vscode
    htop
    btop
    fastfetch
    imagemagick
    xdg-user-dirs
    fzf
    yazi
    gtk3
    gtk4
    spotify
    autotiling
    cliphist
    apple-cursor
    custom-astronaut-theme
    ollama
    gcc
    gnumake
    tree-sitter
    lazygit
    playerctl
    lm_sensors
    ncmpcpp
    mpd
    mpc
    rmpc
    papirus-folders
  ];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
  ];

  # SERVICES

  security.pam.services.swaylock = {};
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "suspend";
      LidSwitchIgnoreInhibited = "no";
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/samarth/Music";
    user = "samarth";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  systemd.services.mpd.serviceConfig = {
    ProtectHome = "read-only"; # Allows MPD to see into /home/samarth
    ProtectSystem = "full";
    Environment = "XDG_RUNTIME_DIR=/run/user/1000";
  };

  services.ollama = {
    enable = true;
    # loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
  };

  # Display Manager
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
      kdePackages.qt5compat
    ];
    wayland.enable = true;
    settings = {
      Theme = {
        ConfigFile = "Themes/astronaut.conf";
      };
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?
}
