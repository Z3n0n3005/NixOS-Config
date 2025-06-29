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
        kdePackages.kate
        neovim
        htop-vim
        obsidian
        gnucash
        poetry
        anki
        zoom-us
        nix-search-cli
        obs-studio
        libreoffice-qt6
        vlc
        clickup
        qbittorrent
        (vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions; [
            # Nix extensions
            bbenoist.nix
            jnoortheen.nix-ide
            
            # Python extensions
            ms-python.python
            ms-python.debugpy
            charliermarsh.ruff
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

        # NixOS related stuffs
        nix-output-monitor
        nix-tree
        
        # Nix Linter and LSP
        nixfmt-rfc-style
        nixd

        # Dealing with screen issues:
        xorg.libxcvt
      ];
    };
  };
}
