{ config, lib, pkgs, ... }:

{
  options = {
    gaming.enable = lib.mkEnableOption "Enables gaming";
  };

  config = lib.mkIf config.gaming.enable {

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };

    environment.systemPackages = with pkgs; [
      bottles
      lutris
      protonup
    ];

    programs.gamemode.enable = true;

    programs.mangohud = {
      enable = true;
      settings = {
        gpu_stats;
        gpu_temp;
        # gpu_junction_temp
        # gpu_core_clock
        # gpu_mem_temp
        # gpu_mem_clock
        # gpu_fan
        # gpu_voltage

        # Display the current CPU information
        cpu_stats;
        cpu_temp;
        cpu_mhz;
        # cpu_power
        # core_load
        # core_load_change

        vram;
        ram;

        fps;
        frametime;
        frame_timing;
        # histogram;

        throttling_status;

        gpu_name;
        vulkan_driver;
        gamemode;

        ### Gamescope related options
        ## Display the status of FSR (only works in gamescope)
        # fsr
        ## Hides the sharpness info for the `fsr` option (only available in gamescope)
        # hide_fsr_sharpness
        ## Shows the graph of gamescope app frametimes and latency (only on gamescope obviously)
        # debug
        ## Display the status of HDR (only works in gamescope)
        # hdr
        ## Display the current refresh rate (only works in gamescope)
        # refresh_rate


        # font_size=24
        # font_scale=1.0
        # font_size_text=24
        # font_scale_media_player=0.55
        # no_small_font
        # font_file=
        # text_outline;
      };
    };

    programs.steam = {
      enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];

  };
}
