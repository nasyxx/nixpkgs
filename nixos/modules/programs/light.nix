{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.light;

in
{
  options = {
    programs.light = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Whether to install Light backlight control with setuid wrapper.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.light ];

    security.permissionsWrappers.setuid =
    [ { program = "light";
        source  = "${pkgs.light.out}/bin/light";
        owner   = "root";
        group   = "root";
        setuid  = true;        
    }];
  };
}
