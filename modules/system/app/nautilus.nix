{ config, lib, pkgs, userSettings, ... }:

{
  options = {
    nautilus.enable = lib.mkEnableOption "Enables nautilus";
  };

  config = lib.mkIf config.nautilus.enable {

    environment = {
      sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
      pathsToLink = [
        "/share/nautilus-python/extensions"
      ];
      systemPackages = with pkgs; [
        nautilus
        nautilus-python
      ];
    };

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "${userSettings.term}";
    };

    programs.file-roller.enable = true;
    services.gnome.sushi.enable = true;
    services.gvfs.enable = true;

    services.tumbler.enable = true;

  };
}
