{ config, lib, pkgs, ... }: 

let
  cfg = config.modules.services.archisteamfarm;
in {
  options.modules.services.archisteamfarm = {
    enable = lib.mkEnableOption "Enable ArchiSteamFarm service";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ArchiSteamFarm ];
  };
}