{ config, lib, pkgs, ... }:

let
  spotifyWaybar = pkgs.writeShellScriptBin "spotifyWaybar" ''
    while true; do
      spotifyctl="playerctl --player=spotify"
      playerStatus=$($spotifyctl status 2>/dev/null)
      if [[ "$playerStatus" == "Playing" ]]; then
        echo "  $($spotifyctl metadata artist) - $($spotifyctl metadata title)"
        elif [[ "$playerStatus" == "Paused" ]]; then
        echo "  $($spotifyctl metadata artist) - $($spotifyctl metadata title)"
      else
        echo ""
      fi
      sleep 0.1
    done
  '';

  wireguardWaybar = pkgs.writeShellScriptBin "wireguardWaybar" ''
    wgStatus() {
      if [[ $(systemctl is-active wg-quick-proton) == "active" ]]; then
        notify-send -a WaybarWG "Wireguard" "Wireguard is running\nRight click module to toggle connection"
      else
        notify-send -a WaybarWG "Wireguard" "Wireguard not is running\nRight click module to toggle connection"
      fi
    }
    wgToggle() {
      if [[ $(systemctl is-active wg-quick-proton) == "active" ]]; then
        systemctl stop wg-quick-proton &&
        notify-send -a WaybarWG "Wireguard" "Stopped wireguard connection"
      else
        systemctl start wg-quick-proton &&
        notify-send -a WaybarWG "Wireguard" "Started wireguard connection"
      fi
    }
    if [[ $1 == "status" ]]; then
      wgStatus
    elif [[ $1 == "toggle" ]]; then
      wgToggle
    else
      notify-send -a WaybarWG "Wireguard" "Invalid arguments\nValid arguments are 'status' or 'toggle'"
    fi
  '';
in
{
  options = {
    waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.waybar.enable {

    home.packages = with pkgs; [
      blueberry
      pavucontrol
      playerctl
      spotifyWaybar
      wireguardWaybar
    ];

    stylix.targets.waybar.enable = false;

    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
      };
      settings = [
        {
          "layer" = "top";
          "position" = "top";
          "margin" = "0";
          "gtk-layer-shell" = true;
          "modules-left" = [
            "custom/launcher"
            "custom/updates"
            "hyprland/workspaces"
            "custom/spotify"
          ];
          "modules-center" = [
          ];
          "modules-right" = [
            "tray"
            "bluetooth"
            "custom/wireguard"
            "network"
            "pulseaudio"
            "clock"
            "custom/power-menu"
          ];
          "custom/launcher" = {
            "format" = "";
            "on-click" = "hyprctl dispatch exec tofi-drun";
            "on-click-right" = "hyprctl dispatch exec tofi-run";
            "tooltip" = false;
          };
          "hyprland/workspaces" = {
            "active-only" = false;
            "all-outputs" = true;
            "disable-scroll" = false;
            "on-scroll-up" = "hyprctl dispatch workspace -1";
            "on-scroll-down" = "hyprctl dispatch workspace +1";
            "format" = "{icon}";
            "on-click" = "activate";
            "format-icons" = {
              "active" = "";
              "default" = "";
              "sort-by-number" = true;
            };
          };
          "custom/spotify" = {
            "exec" = "spotifyWaybar";
            "exec-if" = "pgrep spotify";
            "format" = "  {}";
            "on-click" = "playerctl --player=spotify play-pause";
            "on-click-right" = "hyprctl dispatch workspace 6";
            "on-scroll-up" = "playerctl --player=spotify next";
            "on-scroll-down" = "playerctl --player=spotify previous";
            "tooltip" = false;
          };
          "cpu" = {
            "interval" = 5;
            "format" = "  {}%";
            "max-length" = 10;
            "on-click" = "";
          };
          "memory" = {
            "interval" = 5;
            "format" = " {used:0.1f}GB";
            "format-alt" = "  {}%";
            "max-length" = 10;
          };
          "hyprland/window" = {
            "max-length" = 100;
            "seperate-outputs" = true;
          };
          "tray" = {
            "spacing" = 10;
          };
          "bluetooth" = {
            "format" = "";
            "on-click" = "blueberry";
            "on-click-right" = "bluetoothctl disconnect";
          };
          "network" = {
            "format-wifi" = "{icon}";
            "format-ethernet" = "󰈀";
            "format-disconnected" = "󰖪";
            "tooltip-format" = "{essid}";
            "on-click" = "hyprctl dispatch exec '[float; tag +nmtui] $TERM -e nmtui'";
            "format-icons" = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
          };
          "custom/wireguard" = {
            "format" = "󱠾";
            "on-click" = "$HOME/.config/waybar/wireguard.sh status";
            "on-click-right" = "$HOME/.config/waybar/wireguard.sh toggle";
            "tooltip" = false;
          };
          "pulseaudio" = {
            "format" = "{icon}";
            "format-muted" = "󰸈";
            "format-icons" = {
              "default" = [
                ""
                ""
                "󰕾"
              ];
            };
            "on-click" = "pavucontrol";
            "on-click-right" = "pamixer -t";
            "scroll-step" = 5;
            "on-scroll-up" = "~/.config/waybar/volume.sh --inc";
            "on-scroll-down" = "~/.config/waybar/volume.sh --dec";
          };
          "clock" = {
            "interval" = 60;
            "align" = 0;
            "rotate" = 0;
            "tooltip" = true;
            "tooltip-format" = "{calendar}";
            "format" = "{:%d %b, %H:%M}";
            "format-alt" = "{:%a %b %d, %G}";
            "timezone" = "Europe/Amsterdam";
            "locale" = "nl_NL.UTF-8";
            "calendar" = {
              "on-click-right" = "mode";
              "mode" = "month";
              "mode-mon-col" = 3;
              "on-scroll" = 1;
            };
            "actions" = {
              "on-click-right" = "mode";
              "on-scroll-up" = "shift_down";
              "on-scroll-down" = "shift_up";
            };
          };
          "custom/power-menu" = {
            "format" = " ⏻ ";
            "on-click" = "wlogout";
            "tooltip" = false;
          };
        }
      ];
      style = ''
        @import '/home/bart/.config/color-scheme/active/colors-waybar.css';

        * {
          font-family: JetBrainsMono NF;
          font-size: 13px;
          font-weight: bold;
        }

        /* For a solid bar, use: */
        /* window#waybar { */
        /*   background-color: @background; */
        /* } */

        /* For floating module, use: */
        window#waybar {
          background-color: transparent;
          color: transparent;
        }

        #custom-launcher,
        #custom-updates,
        #workspaces,
        #cpu,
        #memory,
        #custom-spotify,
        #window,
        #tray,
        #bluetooth,
        #network,
        #custom-wireguard,
        #pulseaudio,
        #clock,
        #custom-power-menu {
          background-color: @background;
          color: @foreground;
          margin: 10px 3px 0;
          padding: 0 12px;
          border-radius: 10px;
          /* border: 1px solid @foreground; */
        }

        #custom-launcher {
          color: @color4;
          font-size: 16px;
          margin-left: 10px;
          margin-right: 0;
          padding-left: 10px;
          padding-right: 14px;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
        }

        #workspaces {
          margin-left: 0;
          padding-left: 0;
          padding-right: 4px;
          border-top-left-radius: 0;
          border-bottom-left-radius: 0;
        }

        #workspaces button {
          color: @color4;
          padding-left: 3px;
          padding-right: 8px;
        }

        #workspaces button.active {
          color: @color2a;
          transition: color 0.25s ease;
        }

        #custom-spotify {
          color: @color2a;
        }

        #window {
          color: @color2a;
        }

        window#waybar.empty #window,
        window#waybar.floating #window {
          color: transparent;
          background-color: transparent;
        }

        #tray {
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @color1;
        }

        #bluetooth,
        #network,
        #custom-wireguard,
        #pulseaudio {
          color: @color4;
          background-color: @background;
          padding: 0 12px;
        }

        #bluetooth {
          margin-left: 3px;
          margin-right: 0;
          border-radius: 10px 0 0 10px;
          border-right: none;
        }

        #bluetooth.connected {
          color: @color2a;
        }

        #network,
        #custom-wireguard {
          border-radius: 0;
          border-right: none;
          border-left: none;
          margin-left: 0;
          margin-right: 0;
        }

        #network,
        #custom-wireguard {
          padding-right: 13px;
          padding-left: 10px;
        }

        #network.disconnected {
          color: @color1;
        }

        #pulseaudio {
          border-radius: 0 10px 10px 0;
          border-left: none;
          margin-left: 0;
          margin-right: 3px;
          padding: 0 13px 0 11px;
        }

        #pulseaudio.muted {
          color: @color1;
        }

        #clock {
          color: @color2a;
        }

        #custom-power-menu {
          color: @color4;
          margin-right: 10px;
          padding: 0 12px 0 10px;
        }

        @keyframes blink {
          to {
            background-color: rgba(40, 40, 40, 0.5);
            color: #abb2bf;
          }
        }

        tooltip {
          color: @foreground;
          background-color: @background;
          padding: 10px;
          border-radius: 10px;
        }

        tooltip label {
          padding: 5px;
        }

        label:focus {
          background-color: @background;
        }
      '';
    };

  };
}
