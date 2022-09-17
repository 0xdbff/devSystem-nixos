# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices.crypted.device = "/dev/disk/by-uuid/8acfe9d4-d5e7-4379-bb6d-5a0776b83c60";
  # fileSystems."/".device = "/dev/mapper/nixos";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enableCryptodisk = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "dev-server"; # Define your hostname.
  # networking.nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking = {
  #     # hostId = "deadb33f";
  #     hostName = "nixos";
  #     # domain = "example.com";
  #     dhcpcd.enable = false;
  #     usePredictableInterfaceNames = false;
  #     # interfaces.eth1.ipv4.addresses = [{
  #     #   address = "192.168.1.2";
  #     #   prefixLength = 28;
  #     # }];
  #     # vlans = {
  #     #   vlan100 = { id=100; interface="eth0"; };
  #     #   vlan101 = { id=101; interface="eth0"; };
  #     # };
  #     # interfaces.vlan100.ipv4.addresses = [{
  #     #   address = "10.1.1.2";
  #     #   prefixLength = 24;
  #     # }];
  #     # interfaces.vlan101.ipv4.addresses = [{
  #     #   address = "10.10.10.3";
  #     #   prefixLength = 24;
  #     # }];
  #     defaultGateway = "192.168.1.254";
  #     nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  #   };

  networking = {
    hostName = "dev-server";
    # Don't try to find our domain name or DNS servers because then
    # resolvconf will insert them into /etc/resolv.conf
    dhcpcd.extraConfig =
      ''
      nooption domain_name_servers, domain_name, domain_search, host_name
      nooption ntp_servers
      '';
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    hosts = {
      # archive.is refuses to serve Cloudflare correct records
      # "51.38.113.224" = [ "archive.li" "archive.is" "archive.fo" "archive.today" ];
    };
    domain = null;
  };

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno2.useDHCP = true;
  networking.interfaces.lo.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  networking.networkmanager.enable = true;

  # networking.wireless = {
  #   enable = true;
  #   userControlled.enable = true;
  #   networks = {
  #     FreeWiFi = {};
  #   };
  # };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # enable sway to test...
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true; # so that gtk works properly
  #   extraPackages = with pkgs; [
  #     swaylock
  #     swayidle
  #     wl-clipboard
  #     wf-recorder
  #     mako # notification daemon
  #     grim
  #    #kanshi
  #     slurp
  #     alacritty # Alacritty is the default terminal in the config
  #     dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  #   ];
  #   extraSessionCommands = ''
  #     export SDL_VIDEODRIVER=wayland
  #     export QT_QPA_PLATFORM=wayland
  #     export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  #     export _JAVA_AWT_WM_NONREPARENTING=1
  #     export MOZ_ENABLE_WAYLAND=1
  #   '';
  # };

  services.xserver.layout = "us,pt";

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Nvidia drivers
  # hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # boot.blacklistedKernelModules = [ "nouveau"];

  hardware.opengl = {
        enable = true;
        driSupport = true;
  };

  # hardware.nvidia.prime = {
  #   offload = { enable = true;};
  #   intelBusId = "PCI:0:2:0";
  #   nvidiaBusId = "PCI:1:0:0";
  # };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user accounts. Don't forget to set a password with ‘passwd’.

  # Nightly software
  users= {
      users = {
 	     db = {
 	     isNormalUser = true;
 	     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
 	     shell = pkgs.fish;
 	     packages = with pkgs; [
 	       	firefox-devedition-bin
 	       ];
  	 };

 	 # has only stable software
 	 db_stable = {
 	     isNormalUser = true;
 	     extraGroups = [ "wheel" "networkmanager" "compute" "dev"]; # Enable ‘sudo’ for the user.
 	     shell = pkgs.fish;
 	     packages = with pkgs; [
 	       	firefox-devedition-bin
 	     ];
 	 };

 	 guest = {
 	     isNormalUser = true;
 	     extraGroups = [ "guest" ]; # Enable ‘sudo’ for the user.
 	     shell = pkgs.fish;
 	     packages = with pkgs; [
 	     ];
 	 };

 	 compute = {
 	     isNormalUser = true;
 	     extraGroups = [ "compute" ];
 	     shell = pkgs.fish;
 	     packages = with pkgs; [
	       ];
  	};
     };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    clang
    pciutils
    file
    gnumake
    exa
    fzf
    git
    htop
    #iosevka
    iosevka-bin
    alacritty
    ruby
    ripgrep
    tmux
    nodejs
    wget
    #firefox
    firefox-devedition-bin
    neofetch
    pkgs.neovim-nightly
    binutils
  ];

  # systemd.services.nvidia-control-devices = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  # };
	    
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
