{ config, lib, pkgs, ... }:

let
  cfg = config.modules.services.cloudflare-warp;

in {
  options.modules.services.cloudflare-warp = {
      enable = lib.mkEnableOption "Enable plasma configuration";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.cloudflare-warp ]; # for warp-svc
    systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
    systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically
  };
}
