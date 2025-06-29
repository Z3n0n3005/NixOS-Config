{ config, lib, pkgs, ... }:

let 
  cfg = config.modules.home-manager.plasma;
in
{
  config = lib.mkIf cfg.enable{
    programs = {
      plasma = {
        window-rules = [
          {
            description = "All full screen initially";
            match = {
              window-types = [ "normal" ];
            };
            apply = {
              size = {
                value = "1920, 1000";
                apply = "initially";
              };
              position = {
                value = "0, 0";
                apply = "initially";
              };
            };
          }
        ];
      };
    };
  };
}