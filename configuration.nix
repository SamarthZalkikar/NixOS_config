# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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
  
  programs.fish.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    gnome-tweaks 
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
    # these are all wayland
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
  
  # For Hyprland
  programs.hyprland.enable = true;
  
  # for cursor 
  # For GTK applications outside of X (like in Wayland), set:
  environment.variables = {
    XCURSOR_THEME = "applecore";
    XCURSOR_SIZE = "24";
  };

  environment.gnome.excludePackages = with pkgs.gnome; [
   pkgs.baobab 
   pkgs.epiphany 
   pkgs.simple-scan 
   pkgs.totem 
   pkgs.yelp 
   pkgs.evince 
   pkgs.geary 
   pkgs.gnome-calculator
   pkgs.gnome-contacts
   pkgs.gnome-logs
   pkgs.gnome-maps
   pkgs.gnome-music
   pkgs.gnome-screenshot
   pkgs.gnome-system-monitor
   pkgs.gnome-connections
   pkgs.gnome-console
   pkgs.gnome-terminal
   pkgs.yelp
   pkgs.gnome-calendar
   pkgs.gnome-clocks
   pkgs.gnome-weather
   pkgs.snapshot
   pkgs.seahorse
   pkgs.gnome-tour
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.hurmit
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
  ]; 
  
   system.autoUpgrade.enable = true;
   system.autoUpgrade.allowReboot = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
