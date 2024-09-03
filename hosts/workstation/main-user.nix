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
        obsidian
        libreoffice-qt6
        obs-studio
        zoom-us
        # teams-for-linux
        clickup
        # ArchiSteamFarm
        vlc
        htop-vim
        gnucash
        gitleaks
        sops
        age

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
      ];
      
    };
  };
}
