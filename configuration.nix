{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.samarth = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "samarth";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # For fish shell
  programs.fish.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim  
    wget
    curl 
    git 
    gcc
    cmake 
    ghostty 
    kitty 
    yazi 
    brave 
    librewolf-bin
    apple-cursor
    starship  
    vesktop  
    eza
    yazi 
    neovim 
    fish
    libreoffice-fresh
    btop 
    htop 
    neofetch
    fastfetch
    imagemagick
    obsidian
    zathura
    tmux
    mpv
    lollypop
    ffmpeg
    rustc 
    cargo
    tree
    zip
    unzip
    unrar
    rar
    # Hyprland
    grim 
    rofi-wayland
    wl-clipboard
    cliphist
    slurp
    waybar
    swww
    nwg-look
    blueman
    papirus-icon-theme
    autotiling
    networkmanagerapplet
    dunst
    libnotify
    swaylock-effects
    pamixer
    gruvbox-dark-gtk
    xfce.thunar
    xfce.thunar-volman
    fzf
    bat
    lua
    hypridle
    hyprlock
    wlogout
  ];

  # for sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # # For Hyprland
  # programs.hyprland.enable = true;

  # for cursor 
  # For GTK applications outside of X (like in Wayland), set:
  environment.variables = {
    XCURSOR_THEME = "applecore";
    XCURSOR_SIZE = "24";
  };


  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
  ]; 
  
   system.autoUpgrade.enable = true;
   system.autoUpgrade.allowReboot = false;

  system.stateVersion = "25.05"; 

}
