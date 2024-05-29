{ config, lib, ... }:

{
  options = {
    btop.enable = lib.mkEnableOption "Enables btop";
  };

  config = lib.mkIf config.btop.enable {

    programs.btop = {
      enable = true;
      settings = {
        theme_background = true;
        truecolor = true;
        vim_keys = true;
        rounded_corners = true;
        update_ms = 1500;
        proc_sorting = "cpu lazy";
      };
    };

  };
}
