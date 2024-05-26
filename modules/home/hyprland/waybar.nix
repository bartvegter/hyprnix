{ config, lib, pkgs, ... }:

{
  options = {
    waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.waybar.enable {

    home.file.".config/waybar/" = {
      source = ./dotfiles/.config/waybar;
      recursive = true;
    };

    home.packages = with pkgs; [
      blueberry
      pavucontrol
      playerctl
    ];

    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "hyprland-session.target";
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
            "exec" = "$HOME/.config/waybar/spotify.sh";
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
            "on-click" = "$TERM -e nmtui";
            "format-icons" = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
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
          color: transparent;
          background-color: transparent;
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
        #pulseaudio,
        #clock,
        #custom-power-menu {
          color: @foreground;
          background-color: @background;
          padding: 10px;
          margin: 10px 3px 0;
          border-radius: 10px;
          /* border: 1px solid @foreground; */
        }

        #custom-launcher {
          color: @color4;
          padding-left: 16px;
          margin-left: 10px;
          margin-right: 0;
          border-radius: 10px 0 0 10px;
        }

        #cpu {
          color: @color3;
          margin-right: 0;
          border-radius: 10px 0 0 10px;
        }

        #memory {
          color: @color3;
          margin-left: 0;
          border-radius: 0 10px 10px 0;
        }

        #workspaces {
          padding: 0 4px;
          margin-left: 0;
          border-radius: 0 10px 10px 0;
        }

        #workspaces button {
          color: @color4;
          margin: 0;
          padding: 6px 9px 6px 6px;
          box-shadow: inset 0 -3px transparent;
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

        window#waybar.empty #window, window#waybar.floating #window {
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
        #pulseaudio,
        #network {
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

        #network {
          padding-right: 13px;
          padding-left: 10px;
          border-radius: 0;
          border-right: none;
          border-left: none;
          margin-left: 0;
          margin-right: 0;
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
