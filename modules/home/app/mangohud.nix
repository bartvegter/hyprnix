{ config, lib, pkgs, ... }:

{
  options = {
    mangohud.enable = lib.mkEnableOption "Enables mangohud";
  };

  config = lib.mkIf config.mangohud.enable {

    programs.mangohud = {
      enable = true;
      settings = {
        gpu_stats = true;
        gpu_temp = true;
        # gpu_junction_temp
        # gpu_core_clock
        # gpu_mem_temp
        # gpu_mem_clock
        # gpu_fan
        # gpu_voltage

        # Display the current CPU information
        cpu_stats = true;
        cpu_temp = true;
        cpu_mhz = true;
        # cpu_power
        # core_load
        # core_load_change

        vram = true;
        ram = true;

        fps = true;
        frametime = true;
        frame_timing = true;
        # histogram = true;

        throttling_status = true;

        gpu_name = true;
        vulkan_driver = true;
        gamemode = true;

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

  };
}
