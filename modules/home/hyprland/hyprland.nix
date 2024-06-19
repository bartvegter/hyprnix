{ config, lib, pkgs, systemSettings, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    home.packages = with pkgs; [
      grimblast
      hyprpicker
      killall
    ];

    home.file = {
      ".config/hypr/scripts" = {
        source = ./dotfiles/.config/hypr/scripts;
        recursive = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {

        "$mod" = "SUPER";
        "$scriptDir" = "~/.config/hypr/scripts";


        # - Monitor setup (hyprctl monitors) - #

        monitor = [ 
          "DP-3, 2560x1440@165, auto, 1, vrr,2"
          "    , preferred    , auto, 1, vrr,0"
        ];


        # - Keyboard and mouse & touchpad - #

        input = {
          kb_layout = "${systemSettings.keyboardLayout}";
          kb_variant = "${systemSettings.keyboardVariant}";

          follow_mouse = 1;
          sensitivity = 0;
          accel_profile = "flat";
          force_no_accel = false;
          left_handed = false;

          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
          workspace_swipe_create_new = true;
        };


        # - Layout and styling - #

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 1;

          layout = "dwindle";
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_is_master = true;
        };

        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          fullscreen_opacity = 1.0;

          drop_shadow = false;
          shadow_range = 4;
          shadow_render_power = 3;
          shadow_ignore_window = true;

          blur = {
            enabled = true;
            size = 4;
            passes = 3;
            ignore_opacity = false;
            new_optimizations = true;
            xray = false;
            noise = 0.05;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = false;
          key_press_enables_dpms = false;
          always_follow_on_dnd = true;
          #vrr = true;	    # Global toggle; can also be set on per-monitor basis (see monitor setup above)
          vfr = true;
        };


        exec-once = [
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"


          # - Status bar - #

          ".waybar-wrapped"


          # - Applications - #

          # "[workspace 1 silent] brave"
          "[fullscreen; workspace 6 silent] spotify"
          "[silent] steam"
          "[silent] vesktop"
        ];


        windowrulev2 = [
          # - System applets - #

          "stayfocused, class: (tofi)"
          "stayfocused, class: (polkit-gnome-authentication-agent-1)"

          "pin, class: (blueberry.py)"
          "float, class: (blueberry.py)"
          "size 500 400, class: (blueberry.py)"
          "move 100%-511 55, class: (blueberry.py)"

          # "pin, tag:nmtui"
          # "float, tag:nmtui"

          "pin, class: (pavucontrol)"
          "float, class: (pavucontrol)"
          "size 700 500, class: (pavucontrol)"
          "move 100%-711 55, class: (pavucontrol)"


          # - Gaming - #

          "float, title: (Game Servers)"
          "float, title: (Steam Settings)"
          "float, title: (Friends List)"
          "size 300 600, title: (Friends List)"
          "move 100%-310 100%-610, title: (Friends List)"
          "nofocus, class: (steam), title:^()$"

          "workspace 4 silent, class: (vesktop)"
          "workspace 4 silent, class: (steam)"
          # "workspace 4, title: (Game Servers)"
          "workspace 5, class: (steam_app_)(.*)"
          "workspace 5, class: (cs2)"
          "workspace 5, title: (worldoftanks.exe)"
          # "fullscreen, class: (steam_app_)(.*)"
          # "fullscreen, class: (cs2)"
          # "fullscreen, title: (worldoftanks.exe)"


          # - Thunar - #

          "stayfocused, class: (thunar), title: (Attention)"
          "stayfocused, class: (thunar), title: (Rename)(.*)"
          "stayfocused, class: (thunar), title: (Create New Folder)"
          "float, class: (thunar), title: (?<!.* - Thunar)"
          # "float, class: (thunar), title: ^(Confirm to replace files)"
          # "float, class: (thunar), title: ^(File Operation Progress)"


          # - Picture in Picture (Brave & Firefox) - #

          "pin, title: ^(Picture in picture)$"
          "pin, title: ^(Picture-in-Picture)$"
          "float, title: ^(Picture in picture)$"
          "float, title: ^(Picture-in-Picture)$"
          "size 640 360, title: ^(Picture in picture)$"
          "size 640 360, title: ^(Picture-in-Picture)$"
          "move 100%-651 100%-371, title: ^(Picture in picture)$"
          "move 100%-651 100%-371, title: ^(Picture-in-Picture)$"
          "noinitialfocus, title: ^(Picture in picture)$"
          "noinitialfocus, title: ^(Picture-in-Picture)$"
          "keepaspectratio, title: ^(Picture in picture)$"
          "keepaspectratio, title: ^(Picture-in-Picture)$"


          # - LibreOffice - #

          "float, class: (soffice)"
          "suppressevent maximize, class: (libreoffice)(.*)"


          # - Misc - #

          "float, class: (Viewnior)"


          # - xwaylandvideobridge - #

          "noanim, class: ^(xwaylandvideobridge)$"
          "noblur, class: ^(xwaylandvideobridge)$"
          "maxsize 1 1, class: ^(xwaylandvideobridge)$"
          "noinitialfocus, class: ^(xwaylandvideobridge)$"
          "opacity 0.0 override 0.0 override, class: ^(xwaylandvideobridge)$"
        ];


        workspace = [
          "1, defaultName: brave"
          "4, defaultName: gaming"
          "5, defaultName: activeGame"
          "6, defaultName: spotify, on-created-empty: [fullscreen] spotify"
        ];


        bind = [
          # - Launching applications - #

          "$mod, B, exec, brave"
          "$mod, Y, exec, obsidian"
          "$mod, C, exec, codium"
          "$mod, E, exec, thunar"
          "$mod, RETURN, exec, alacritty"
          "$mod SHIFT, RETURN, exec, alacritty -e ranger"
          "$mod, W, exec, $scriptDir/logactivewindow.sh"
          "$mod SHIFT, W, exec, $scriptDir/reloadWaybar.sh"


          # - Launching menus - #

          "$mod, N, exec, hyprlock"
          "$mod, M, exec, wlogout"
          "$mod, D, exec, tofi-drun | xargs hyprctl dispatch exec --"
          "$mod SHIFT, D, exec, tofi-run | xargs hyprctl dispatch exec --"
          "$mod, V, exec, cliphist list | tofi | cliphist decode | wl-copy"


          # - Taking screenshots - #

          "$mod, S, exec, grimblast --notify copysave area"
          "$mod SHIFT, S, exec, grimblast --notify copysave active"
          "$mod CTRL, S, exec, grimblast --notify copysave screen"


          # - Color picker - #

          "$mod, X, exec, hyprpicker -f hex --autocopy"
          "$mod SHIFT, X, exec, hyprpicker -f rgb --autocopy"


          # - Window commands - #

          "$mod, Q, killactive"
          "$mod, F, fullscreen"
          "$mod, I, togglesplit"
          "$mod, O, pseudo"
          "$mod, SPACE, togglefloating"


          # - Moving focus across windows - #

          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"


          # - Moving focus between workspaces (relative) - #

          "$mod, bracketleft, workspace, e-1"
          "$mod, bracketright, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod, mouse_down, workspace, e+1"


          # - Moving focus between workspaces (absolute) - #

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"


          # - Moving window left/down/up/right - #

          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, L, movewindow, r"


          # - Moving window between workspaces - #

          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"


          # - Resizing current window - #

          "$mod CTRL, H, resizeactive, -100 0"
          "$mod CTRL, J, resizeactive, 0 100"
          "$mod CTRL, K, resizeactive, 0 -100"
          "$mod CTRL, L, resizeactive, 100 0"
        ];
        bindm = [
          # - Using the mouse - #

          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };

  };
}
