{ config, lib, pkgs, ... }: 

let
  cfg = config.modules.services.archisteamfarm;
  username_path = config.sops.secrets."services/archisteamfarm/bots/cardidling/username".path;
in {
  options.modules.services.archisteamfarm = {
    enable = lib.mkEnableOption "Enable ArchiSteamFarm service";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ArchiSteamFarm ];
    
    sops.secrets."services/archisteamfarm/bots/cardidling/username" = {
      restartUnits = ["archisteamfarm.service"];
      owner = config.main-user.userName;
    };
    sops.secrets."services/archisteamfarm/bots/cardidling/password" = {
      restartUnits = ["archisteamfarm.service"];
      owner = "archisteamfarm";
    };


    services.archisteamfarm = {
      enable = true;
      web-ui.enable = true;

      settings = {
        DefaultBot = "Card Idling";
        # SteamOwnerID = 76561198967857357;
      };
      bots = {
        cardidling = {
          enabled = true;
          username = pkgs.runCommand "get_asf_username" {} ''cat ${username_path}'';
          passwordFile = config.sops.secrets."services/archisteamfarm/bots/cardidling/password".path;
          settings = {
            CustomGamePlayedWhileFarming = "Card Idling";
            OnlineStatus = 3;
          };
        };
      };
    };
  };
}