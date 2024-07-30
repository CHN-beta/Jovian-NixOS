{ config, lib, ... }:
let
  cfg = config.jovian.overlay;
in
{
  options = {
    jovian = {
      overlay = {
        enable = lib.mkOption {
          default = true;
          type = lib.types.bool;
          description = ''
            Whether to enable the Jovian NixOS overlay.
          '';
        };
        allowUnsupportedNixpkgs = lib.mkOption {
          default = false;
          type = lib.types.bool;
          description = ''
            Whether to allow using Jovian NixOS with unsupported Nixpkgs versions.
          '';
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable) {
    nixpkgs.overlays =  [
      (import ../../overlay.nix)
    ];

    assertions = lib.mkIf (!cfg.allowUnsupportedNixpkgs) [
      {
        # Can't use 23.11 here because git versions are tracked as 23.11pre,
        # which is considered to be < 23.11.
        assertion = lib.versionAtLeast lib.version "23.10";
        message = "Jovian NixOS is only validated with the nixos-unstable branch of Nixpkgs. Please upgrade your Nixpkgs version.";
      }
    ];
  };
}
