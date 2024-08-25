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
        kate
        neovim
        htop-vim
        obsidian
        (vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions; [
            bbenoist.nix
            ms-python.python
            ms-vscode-remote.remote-ssh
            ms-toolsai.jupyter
            vscodevim.vim
            jnoortheen.nix-ide
            dracula-theme.theme-dracula
          ];
        })
        python3
        python312Packages.pip
        python312Packages.notebook
        python312Packages.jupyterlab
        python312Packages.ipykernel  
        zoom-us
        jupyter    
        nix-search-cli
        obs-studio
        libreoffice-qt6
      ];
    };
  };
}
