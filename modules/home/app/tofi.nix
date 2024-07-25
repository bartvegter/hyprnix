{ config, lib, pkgs, ... }:

{
  options = {
    tofi.enable = lib.mkEnableOption "Enables tofi";
  };

  config = lib.mkIf config.tofi.enable {

    programs.tofi = {
      enable = true;
      settings = {

        font = "JetBrainsMono NF";
        # font-size = 13;
        hint-font = true;
        # text-color = "#EBDBB2";

        # prompt-background = "#00000000";
        prompt-background-padding = 0;
        prompt-background-corner-radius = 0;

        # placeholder-color = "#FFFFFFA8";
        # placeholder-background = "#00000000";
        placeholder-background-padding = 0;
        placeholder-background-corner-radius = 0;

        # input-background = "#00000000";
        input-background-padding = 0;
        input-background-corner-radius = 0;

        # default-result-background = "#00000000";
        default-result-background-padding = 0;
        default-result-background-corner-radius = 0;

        # selection-color = "#EBDBB2";
        # selection-background = "#32302FFF";
        selection-background-padding = 3;
        selection-background-corner-radius = 0;
        # selection-match-color = "#B8BB26FF";

        text-cursor-style = "bar";
        text-cursor-corner-radius = 0;

        prompt-text = "search: ";
        prompt-padding = 0;

        placeholder-text = "";
        num-results = 0;
        result-spacing = 10;
        horizontal = false;
        min-input-width = 0;

        width = 640;
        height = 480;

        # background-color = "#282828";
        outline-width = 0;
        # outline-color = "#B16286";
        border-width = 2;
        # border-color = "#EBDBB2";
        corner-radius = 10;

        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        padding-top = 8;
        padding-bottom = 8;
        padding-left = 8;
        padding-right = 8;

        clip-to-padding = true;
        scale = true;

        output = "";
        anchor = "center";

        exclusive-zone = -1;

        hide-cursor = false;
        text-cursor = false;
        history = true;
        matching-algorithm = "normal";
        require-match = true;
        auto-accept-single = false;
        hide-input = false;
        hidden-character = "*";
        physical-keybindings = true;
        print-index = false;
        drun-launch = false;
        late-keyboard-init = false;
        multi-instance = false;
        ascii-input = false;
      };
    };
  };
}
