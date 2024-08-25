{ config, lib, pkgs, ...}:

let
  cfg = config.modules.home-manager.plasma;
in
{
  options.modules.home-manager.plasma = {
    enable = lib.mkEnableOption "Enable plasma configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.plasma = {
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        cursor = {
          size = 24;
        };
        wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Mountain/contents/images/5120x2880.png";
      };

      hotkeys.commands."launch-konsole" = {
        name = "Launch Konsole";
        key = "Meta+Alt+K";
        command = "konsole";
      };

      fonts = {
        general = {
          family = "JetBrains Mono";
          pointSize = 10;
        };
      };

      panels = [
        # Windows-like panel on the left 
        {
          location = "left";
          widgets = [
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                ];
              };
            }
            
            "org.kde.plasma.marginsseparator"
            
            {
              digitalClock = {
                calendar.firstDayOfWeek = "sunday";
                time.format = "24h";
                font = {
                  family = "JetBrains Mono";
                  bold = false;
                  size = 40;
                };
                size = { width = 500; height = 500;};
                date.enable = false;
              };
            }
            {
              systemTray.items = {
                # We explicitly show bluetooth and battery
                shown = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
                # And explicitly hide networkmanagement and volume
                hidden = [
                ];
              };
            }
          ];
          hiding = "none";
          floating = true;
        }
      ];

      window-rules = [
        {
          description = "All full screen initially";
          match = {
            window-types = [ "normal" ];
          };
          apply = {
            maximizehoriz = true;
            maximizevert = true;
          };
        }
      ];

      powerdevil = {
        AC = {
          powerButtonAction = "lockScreen";
          autoSuspend = {
            action = "sleep";
            idleTimeout = 600;
          };
          turnOffDisplay = {
            idleTimeout = 300;
            idleTimeoutWhenLocked = "immediately";
          };
        };
        battery = {
          powerButtonAction = "sleep";
          whenSleepingEnter = "standbyThenHibernate";
        };
        lowBattery = {
          whenLaptopLidClosed = "hibernate";
        };
      };

      kwin = {
        edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
        cornerBarrier = false;

        # scripts.polonium.enable = true;
      };

      kscreenlocker = {
        lockOnResume = true;
        timeout = 10;
      };

      #
      # Some mid-level settings:
      #
      shortcuts = {
        ksmserver = {
          "Lock Session" = [ "Screensaver" "Meta+Ctrl+Alt+L" ];
        };

        kwin = {
          "Expose" = "Meta+,";
          "Switch Window Down" = "Meta+J";
          "Switch Window Left" = "Meta+H";
          "Switch Window Right" = "Meta+L";
          "Switch Window Up" = "Meta+K";
        };
      };


      #
      # Some low-level settings:
      #
      configFile = {
        baloofilerc."Basic Settings"."Indexing-Enabled" = false;
        kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "SF";
        kwinrc.Desktops.Number = {
          value = 8;
          # Forces kde to not change this value (even through the settings app).
          immutable = true;
        };
        kscreenlockerrc = {
          Greeter.WallpaperPlugin = "org.kde.potd";
          # To use nested groups use / as a separator. In the below example,
          # Provider will be added to [Greeter][Wallpaper][org.kde.potd][General].
          "Greeter/Wallpaper/org.kde.potd/General".Provider = "bing";
        };
      }; 
    };
  };

}