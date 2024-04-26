{ config, lib, pkgs, ... }:

let
  icons = "${pkgs.wlogout}" + "/share/wlogout/icons";
in
{
  options = {
    wlogout.enable = lib.mkEnableOption "Enables wlogout";
  };

  config = lib.mkIf config.wlogout.enable {

    programs.wlogout = {
      enable = true;
      layout = [
        {
          "label" = "lock";
          "action" = "hyprlock";
          "text" = "Lock";
          "keybind" = "l";
        }
        {
          "label" = "hibernate";
          "action" = "systemctl hibernate";
          "text" = "Hibernate";
          "keybind" = "h";
        }
        {
          "label" = "logout";
          "action" = "loginctl kill-session $XDG_SESSION_ID";
          "text" = "Logout";
          "keybind" = "e";
        }
        {
          "label" = "shutdown";
          "action" = "systemctl poweroff";
          "text" = "Shutdown";
          "keybind" = "s";
        }
        {
          "label" = "suspend";
          "action" = "systemctl suspend";
          "text" = "Suspend";
          "keybind" = "u";
        }
        {
          "label" = "reboot";
          "action" = "systemctl reboot";
          "text" = "Reboot";
          "keybind" = "r";
        }
      ];

      style = ''
        @import '/home/bart/.config/color-scheme/active/colors-waybar.css';

        * {
            font-family: JetBrainsMono NF;
            font-size: 16px;
            background-image: none;
            box-shadow: none;
        }

        window {
            background-color: rgba(12, 12, 12, 0.9);
        }

        button {
            border-radius: 100%;
            border-color: @background;
            text-decoration-color: @background;
            color: @foreground;
            background-color: @background;
            border-style: none;
            border-width: 1px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 14%;
            margin: 45px 150px;
        }

        button:focus, button:active, button:hover {
            color: @background;
            background-color: @color2;
            outline-style: none;
        }

        #lock {
            background-image: image(url("${icons}/lock.png"), url("${icons}/lock.png"));
        }

        #logout {
            background-image: image(url("${icons}/logout.png"), url("${icons}/logout.png"));
        }

        #suspend {
            background-image: image(url("${icons}/suspend.png"), url("${icons}/suspend.png"));
        }

        #hibernate {
            background-image: image(url("${icons}/hibernate.png"), url("${icons}/hibernate.png"));
        }

        #shutdown {
            background-image: image(url("${icons}/shutdown.png"), url("${icons}/shutdown.png"));
        }

        #reboot {
            background-image: image(url("${icons}/reboot.png"), url("${icons}/reboot.png"));
        }
      '';
    };

  };
}
