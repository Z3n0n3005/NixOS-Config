{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
  };
  
  

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = "TriVy";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = with pkgs; [
        firefox
        kate
        obsidian
        libreoffice-qt6
        obs-studio
        zoom-us
        clickup
        # ArchiSteamFarm
        vlc
        htop-vim
        gnucash
        gitleaks
        sops
        age
        unzip
        masterpdfeditor

        (vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions; [
            # Nix extensions
            bbenoist.nix
            jnoortheen.nix-ide
            
            # Python extensions
            ms-python.python
            ms-python.debugpy
            ms-python.pylint
            ms-python.vscode-pylance
            ms-toolsai.jupyter

            # SSH extension
            ms-vscode-remote.remote-ssh
            ms-azuretools.vscode-docker
            
            # Terraform
            hashicorp.terraform
            
            # Utilities
            vscodevim.vim
            
            # Syntax appearance
            mechatroner.rainbow-csv
            usernamehw.errorlens
          ];
        })
        poetry
        # postgresql
        prismlauncher
        mcaselector
        gimp

        # blender-hip
      ];
      
    };
  };
}
