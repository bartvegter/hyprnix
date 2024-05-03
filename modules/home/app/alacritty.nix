{ config, lib, ... }:

{
  options = {
    alacritty.enable = lib.mkEnableOption "Enables alacritty";
  };

  config = lib.mkIf config.alacritty.enable {

    programs.alacritty = {
      enable = true;
      settings = {
        import = [
          "~/.config/color-scheme/active/colors-alacritty.toml"
          "~/.config/alacritty/keybinds.toml"
        ];

        window = {
          padding = { x = 15; y = 15; };
          opacity = 0.8;
        };

        font = {
          normal = { family = "JetBrainsMono NF"; style = "Medium"; };
          size = 11;
        };

        colors.draw_bold_text_with_bright_colors = true;

        cursor = {
          style = { shape = "Block"; blinking = "Off"; };
          vi_mode_style = { shape = "Beam"; blinking = "Off"; };
        };

        terminal.osc52 = "OnlyCopy";

        mouse.hide_when_typing = false;
      };
    };

  };
}
