{ config, lib, ... }:

{
  options = {
    mako.enable = lib.mkEnableOption "Enables mako";
  };

  config = lib.mkIf config.mako.enable {

    services.mako = {
      enable = true;
      actions = true;
      sort = "-time";
      defaultTimeout = 5000;

      markup = true;
      font = "JetBrainsMono 9";
      format = "<b>%s</b>\\n%b";
      icons = true;
      maxIconSize = 64;

      layer = "overlay";
      anchor = "top-right";
      maxVisible = 5;
      width = 350;
      height = 100;
      margin = "20";
      padding= "8";
      borderSize = 1;
      borderRadius = 10;

      textColor = "#EBDBB2";
      borderColor = "#EBDBB2";
      backgroundColor = "#282828";
      progressColor = "over #B8BB26";
    };

  };
}
