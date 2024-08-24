# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./main-user.nix
      inputs.home-manager.nixosModules.default
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

  # Experimental
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.inputMethod =  {
  #   type = "fcitx5";
  #   enable = true;
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-bamboo
  #   ];
  #   fcitx5.waylandFrontend = true;
  # };
  # i18n.inputMethod.ibus.panel = [
  #   "${pkgs.plasma5Packages.plasma-desktop}/libexec/kimpanel-ibus-panel"
  # ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
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
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.trivy = {
  #    isNormalUser = true;
  #    description = "TriVy";
  #    extraGroups = [ 
  #      "networkmanager" 
  #      "wheel"
  #      "docker" 
  #    ];
  #    packages = with pkgs; [
  #     firefox
  #     kate
  #     neovim
  #     htop-vim
  #     (vscode-with-extensions.override {
  #       vscodeExtensions = with vscode-extensions; [
  #         bbenoist.nix
  #         ms-python.python
  #         ms-vscode-remote.remote-ssh
  #         ms-toolsai.jupyter
  #         vscodevim.vim
  #         jnoortheen.nix-ide
  #         dracula-theme.theme-dracula
  #       ];
  #     })
  #     python3
  #     python312Packages.pip
  #     python312Packages.notebook
  #     python312Packages.jupyterlab
  #     python312Packages.ipykernel  
  #     zoom-us
  #     jupyter    
  #     nix-search-cli
  #   ];
  # };
  main-user.enable = true;
  main-user.userName = "trivy";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "trivy" = import ./home.nix;
    };
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # kdePackages.kclock
    vim 
    p7zip
    curl
    wget
    docker
    git
    gh
  ];

  virtualisation.docker.enable = true;

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
  system.stateVersion = "23.05"; # Did you read the comment?

}
