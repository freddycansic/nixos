# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  options,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pc";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;
    windowManager.leftwm.enable = true;
  };

  services.logind.extraConfig = "RuntimeDirectorySize=4G";

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "mac";
  };

  # Configure console keymap
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.rtkit.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.freddy = {
    isNormalUser = true;
    description = "Freddy Cansick";
    extraGroups = ["networkmanager" "wheel" "wireshark"];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "Meslo"];})
  ];

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "freddy";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.systemPackages = [
    pkgs.wget
    pkgs.unzip
    pkgs.alejandra
    pkgs.helix
    pkgs.git
    pkgs.zsh
    pkgs.wireshark
    pkgs.inetutils # ftp, ifconfig, etc
    pkgs.util-linux
    pkgs.openvpn3
    pkgs.easyeffects
    pkgs.gcc
    pkgs.cmake
    pkgs.gnumake
    pkgs.wev # display keypresses
    pkgs.fd
    pkgs.xclip

    pkgs.python3
    inputs.nixpkgs-ruby.packages.x86_64-linux."ruby-3.2.2"

    # Libraries
    pkgs.zlib
    pkgs.libffi
    pkgs.openssl
    pkgs.libedit
    pkgs.libnotify
    pkgs.readline
    pkgs.shaderc
    pkgs.libGL
    pkgs.libxkbcommon
    pkgs.fontconfig
    pkgs.vulkan-headers
    pkgs.vulkan-loader
    pkgs.vulkan-validation-layers

    # pkgs.mako
    pkgs.dunst
    pkgs.xdg-desktop-portal-gtk
  ];

  programs.wireshark.enable = true;
  programs.openvpn3.enable = true;

  # programs.hyprland = {
  #   enable = true;
  #   enableNvidiaPatches = true;
  #   xwayland.enable = true;
  # };

  programs.zsh.enable = true;

  programs.gnupg.agent.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.openjdk17;
  };

  programs.nix-ld = {
    enable = true;
    # Add missing dynamic libraries for unpackaged programs here
    libraries =
      options.programs.nix-ld.libraries.default
      ++ [
        pkgs.wayland
        pkgs.libxkbcommon
        pkgs.fontconfig
        pkgs.vulkan-headers
        pkgs.vulkan-loader
        pkgs.vulkan-validation-layers
        pkgs.vulkan-tools
        pkgs.zlib
        pkgs.xorg.libX11
        pkgs.xorg.libXcursor
        pkgs.xorg.libxcb
        pkgs.xorg.libXi
      ];
  };

  location = {
    provider = "manual";
    latitude = 52.2;
    longitude = -1.2;
  };

  services.redshift = {
    enable = true;
  };

  systemd.user.services.refresh-rate = {
    description = "Set the refresh rate to 144";
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      xrandr --output DP-0 --mode 1920x1080 --rate 144
    '';
    wantedBy = ["multi-user.target"]; # Run script after login
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    # NIXOS_OZONE_WL = "1";
    VULKAN_SDK = "${pkgs.vulkan-headers}";
    VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        pkgs.mesa_drivers
      ];
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      forceFullCompositionPipeline = true; # Vsync?
      nvidiaSettings = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

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
  system.stateVersion = "23.11"; # Did you read the comment?
}
