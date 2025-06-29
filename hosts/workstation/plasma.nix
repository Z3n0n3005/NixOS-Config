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
            description = "All full screen initially.";
            match = {
              window-types = [ "normal" ];
            };
            apply = {
              maximizehoriz = true;
              maximizevert = true;
            };
          }
        ];
      };
    };
  };
}