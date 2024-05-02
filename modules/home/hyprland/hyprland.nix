{ config, lib, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    home.sessionVariables = {
        # XDG_SESSION_DESKTOP = "Hyprland";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        #
      };
      extraConfig = ''
        # ---------------------------------------- #
        # --- Hyprland dotfiles by @bartvegter --- #
        # ---------------- @ 2024 ---------------- #
        # --- ref @ https://wiki.hyprland.org/ --- #
        # ---------------------------------------- #


        # - Setting variables - #

        $hyprc = ~/.config/hypr
        $scripts = ~/.config/hypr/scripts


        # - Sourcing other config files - #

        # source = $hyprc/startup.conf
        # source = $hyprc/envvar.conf
        # source = $hyprc/keybinds.conf
        # source = $hyprc/windowrule.conf

        source = ~/.config/color-scheme/active/colors-hyprland.conf


        # - Monitor setup (hyprctl monitors) - #

        monitor=DP-3, 2560x1440@165, 0x0,1, vrr,0


        # - Keyboard and mouse & touchpad - #

        input {
          kb_layout = us
          kb_variant = altgr-intl
          follow_mouse = 1

          touchpad {
            natural_scroll = true
          }

          sensitivity = 0 
          accel_profile = flat
          force_no_accel = false
          left_handed = false
        }

        gestures {
          workspace_swipe = true
          workspace_swipe_fingers = 3
          workspace_swipe_create_new = true
        }


        # - Layout and styling - #

        general {
          gaps_in = 5
          gaps_out = 10
          border_size = 1
          col.active_border = $foreground
          col.inactive_border = $background

          layout = dwindle
        }

        dwindle {
          pseudotile = yes
          preserve_split = yes
        }

        master {
          new_is_master = true
        }

        decoration {
          rounding = 10
          active_opacity = 1.0 
          inactive_opacity = 1.0
          fullscreen_opacity = 1.0

          drop_shadow = false
          shadow_range = 4
          shadow_render_power = 3
          shadow_ignore_window = true
          col.shadow = rgba(282828aa)

          blur {
            enabled = true
            size = 4
            passes = 3
            ignore_opacity = false
            new_optimizations = true
            xray = false
            noise = 0.05
          }
        }

        animations {
          enabled = yes

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        }

        misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
          mouse_move_enables_dpms = false
          key_press_enables_dpms = false
          always_follow_on_dnd = true
          #vrr = true	    # Global toggle; can also be set on per-monitor basis (see monitor setup above)
          vfr = true
        }


        # ---------------------------------------- #
        # --- Hyprland dotfiles by @bartvegter --- #
        # ---------------- @ 2024 ---------------- #
        # ------------- Startup file ------------- #
        # ---------------------------------------- #


        # - Clipboard initialisation
        exec-once = wl-paste --type text --watch cliphist store
        exec-once = wl-paste --type image --watch cliphist store

        # - Notification deamon
        exec-once = mako

        # - Automatic disk mounting utility
        exec-once = $scripts/wallpaper/wallpaper.sh
        exec-once = hyprpaper

        # - Status bar
        exec-once = .waybar-wrapped

        # - Applications
        exec-once = [workspace 1 silent] brave
        exec-once = spotify
        exec-once = steam
        exec-once = webcord


        # ---------------------------------------- #
        # --- Hyprland dotfiles by @bartvegter --- #
        # ---------------- @ 2024 ---------------- #
        # ----------- Windowrules file ----------- #
        # ---------------------------------------- #


        # - Window opacity - #

        #windowrulev2 = opacity 0.90 0.90, class:(Brave-browser)$
        #windowrulev2 = opaque, class:^(Brave-browser), title:^(.*)(YouTube)(.*)$
        #windowrulev2 = opacity 0.90 0.90, class:^(VSCodium)$
        #windowrulev2 = opacity 0.90 0.90, class:^(obsidian)$
        #windowrulev2 = opacity 0.85 0.85, class:^(WebCord)$
        #windowrulev2 = opacity 0.80 0.80, class:^(steam)$
        #windowrulev2 = opacity 0.80 0.80, class:^(steamwebhelper)$
        #windowrulev2 = opacity 0.80 0.80, class:^(Spotify)$
        #windowrulev2 = opacity 0.80 0.80, class:^(thunar)$
        #windowrulev2 = opacity 0.80 0.80, class:^(file-roller)$
        #windowrulev2 = opacity 0.80 0.80, class:^(nwg-look)$
        #windowrulev2 = opacity 0.80 0.80, class:^(qt5ct)$
        #windowrulev2 = opacity 0.80 0.80, class:^(qt6ct)$
        #windowrulev2 = opacity 0.80 0.70, class:^(pavucontrol)$
        #windowrulev2 = opacity 0.80 0.70, class:^(org.kde.polkit-kde-authentication-agent-1)$


        # - Window position - #

        windowrulev2 = float, title:^(Friends List)$
        windowrulev2 = float, title:^(Steam Settings)$
        windowrulev2 = float, title:^(Bluetooth)$
        windowrulev2 = float, class:^(gedit)$
        windowrulev2 = float, class:^(org.kde.polkit-kde-authentication-agent-1)$
        windowrulev2 = float, class:^(nwg-look)$
        windowrulev2 = float, class:^(pavucontrol)$
        windowrulev2 = float, class:^(Viewnior)$
        windowrulev2 = float, title:^(Confirm to replace files)
        windowrulev2 = float, title:^(File Operation Progress)
        windowrulev2 = float, title:^(Media viewer)$
        windowrulev2 = float, title:^(Picture in picture)$
        windowrulev2 = float, title:^(Picture-in-Picture)$
        windowrulev2 = float, class:^(soffice)$
        windowrulev2 = move 100%-652 100%-372, title:^(Picture in picture)$
        windowrulev2 = move 100%-652 100%-372, title:^(Picture-in-Picture)$
        windowrulev2 = pin, title:^(Picture in picture)$
        windowrulev2 = pin, title:^(Picture-in-Picture)$


        # - Workspace rules - #

        windowrulev2 = workspace 5 silent, title:^(Spotify Premium)$
        windowrulev2 = workspace 4 silent, class:^(WebCord)$
        windowrulev2 = workspace 4 silent, class:^(steam)$
        windowrulev2 = workspace 6, class:^(steam_app_)(.*)$
        windowrulev2 = workspace 6, title:^(worldoftanks.exe)$


        # - Window size - #

        windowrulev2 = size 640 360, title:^(Picture in picture)$
        windowrulev2 = size 640 360, title:^(Picture-in-Picture)$
        windowrulev2 = size 800 600, title:^(Volume Control)$
        windowrulev2 = size 800 600, class:^(nwg-look)$
        windowrulev2 = keepaspectratio, title:^(Picture in picture)$
        windowrulev2 = keepaspectratio, title:^(Picture-in-Picture)$
        windowrulev2 = fullscreen, class:^(Nsxiv)$


        # - Focus & Behaviour - #

        windowrulev2 = nofocus, class:^(steam)$, title:^()$
        windowrulev2 = noinitialfocus, title:^(Picture in picture)$
        windowrulev2 = noinitialfocus, title:^(Picture-in-Picture)$
        windowrulev2 = stayfocused, class:(tofi)$
        windowrulev2 = stayfocused, class:(soffice)$
        #windowrulev2 = stayfocused, class:(file-roller)$
        windowrulev2 = stayfocused, class:(thunar), title:(Attention)$
        windowrulev2 = stayfocused, class:(thunar), title:(Rename)(.*)$
        windowrulev2 = stayfocused, class:(thunar), title:(Create New Folder)$
        #windowrulev2 = stayfocused, class:^(firefox), title:^(Save)(.*)$
        windowrulev2 = suppressevent maximize, class:^(VSCodium)$
        windowrulev2 = suppressevent maximize, class:^(libreoffice)(.*)$


        # - xwaylandvideobridge - #

        windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
        windowrulev2 = noanim,class:^(xwaylandvideobridge)$
        windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
        windowrulev2 = maxsize 1 1,class:^(xwaylandvideobridge)$
        windowrulev2 = noblur,class:^(xwaylandvideobridge)$


        # ---------------------------------------- #
        # --- Hyprland dotfiles by @bartvegter --- #
        # ---------------- @ 2024 ---------------- #
        # ----------- Keybindings file ----------- #
        # ---------------------------------------- #


        $mainMod = SUPER
        bind = $mainMod, U, exec, alacritty -e nvim


        # - Launching applications - #

        bind = $mainMod, B, exec, brave
        bind = $mainMod, T, exec, firefox
        bind = $mainMod, Y, exec, obsidian
        bind = $mainMod, C, exec, vscodium
        bind = $mainMod, E, exec, thunar
        bind = $mainMod, RETURN, exec, alacritty
        bind = $mainMod SHIFT, RETURN, exec, alacritty -e ranger
        bind = $mainMod, W, exec, $scripts/logactivewindow.sh
        bind = $mainMod SHIFT, W, exec, systemctl --user restart waybar.service
        bind = $mainMod, HOME, exec, thunar ~/Documents/Pokemon/ROMHacks/.ROMPatcher


        # - Launching menus - #

        bind = $mainMod, N, exec, hyprlock
        bind = $mainMod, M, exec, wlogout
        bind = $mainMod, D, exec, tofi-drun | xargs hyprctl dispatch exec --
        bind = $mainMod SHIFT, D, exec, tofi-run | xargs hyprctl dispatch exec --
        bind = $mainMod, V, exec, cliphist list | tofi | cliphist decode | wl-copy


        # - Taking screenshots - #

        bind = $mainMod, S, exec, grimblast --notify copysave area
        bind = $mainMod SHIFT, S, exec, grimblast --notify copysave active
        bind = $mainMod CTRL, S, exec, grimblast --notify copysave screen


        # - Color picker - #

        bind = $mainMod, X, exec, hyprpicker -f hex --autocopy
        bind = $mainMod SHIFT, X, exec, hyprpicker -f rgb --autocopy


        # - Window commands - #

        bind = $mainMod, Q, killactive
        bind = $mainMod, F, fullscreen
        bind = $mainMod, I, togglesplit
        bind = $mainMod, O, pseudo
        bind = $mainMod, SPACE, togglefloating


        # - Moving focus across windows - #

        bind = $mainMod, H, movefocus, l
        bind = $mainMod, J, movefocus, d
        bind = $mainMod, K, movefocus, u
        bind = $mainMod, L, movefocus, r


        # - Moving focus between workspaces (relative) - #

        bind = $mainMod, bracketleft, workspace, e-1
        bind = $mainMod, bracketright, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1
        bind = $mainMod, mouse_down, workspace, e+1


        # - Moving focus between workspaces (absolute) - #

        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10


        # - Moving window left/down/up/right - #

        bind = $mainMod SHIFT, H, movewindow, l
        bind = $mainMod SHIFT, J, movewindow, d
        bind = $mainMod SHIFT, K, movewindow, u
        bind = $mainMod SHIFT, L, movewindow, r


        # - Moving window between workspaces - #

        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # - Resizing current window - #

        bind = $mainMod CTRL, H, resizeactive, -100 0
        bind = $mainMod CTRL, J, resizeactive, 0 100
        bind = $mainMod CTRL, K, resizeactive, 0 -100
        bind = $mainMod CTRL, L, resizeactive, 100 0

        # - Using the mouse - #

        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
      '';
    };

  };
}
