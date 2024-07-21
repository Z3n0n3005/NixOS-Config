{ pkgs, lib, ... }: {
  import = 
  [
    ./nixos/default.nix
    ./services/default.nix
    ./home-manager/default.nix
  ]
}
