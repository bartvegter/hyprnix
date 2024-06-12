{ config, lib, ... }:

{
  options = {
    hyprlock.enable = lib.mkEnableOption "Enables hyprlock";
  };

  config = lib.mkIf config.hyprlock.enable {

    programs.hyprlock = {
      enable = true;
      settings = {

        general = {
            disable_loading_bar = true;
            hide_cursor = true;
            # grace = 5;
        };

        background = {
            monitor = "DP-3";
            path = "${config.stylix.image}";
            blur_passes = 4;
            blur_size = 3;
            noise = 0.05;
        };

        label = {
            monitor = "DP-3";
            text = "$TIME";
            color = "rgb(235, 219, 178)";
            font_size = 30;
            font_family = "${config.stylix.fonts.monospace.name}";

            position = "0, 0";
            halign = "center";
            valign = "center";
        };

        input-field = {
            monitor = "DP-3";
            size = "250, 40";
            outline_thickness = 2;
            dots_size = 0.25;
            dots_spacing = 0.3;

            outer_color = "rgb(235, 219, 178)";
            inner_color = "rgb(40, 40, 40)";
            font_color = "rgb(235, 219, 178)";

            check_color = "rgb(215,153,33)";
            fail_color = "rgb(204,36,29)";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty";

            position = "0, -200";
            halign = "center";
            valign = "center";
        };
      };
    };

  };
}
