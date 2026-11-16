{pkgs, ...}: let
  eDP = "China Star Optoelectronics Technology Co. Ltd MNG007DA5-4";
  DP = "HKC OVERSEAS LIMITED X5 0000000000001";

  env = {
    # Required for quantized KV cache below.
    OLLAMA_FLASH_ATTENTION = "1";
    # Halves KV cache; 32k context costs ~0.5GiB instead of ~1.0GiB.
    OLLAMA_KV_CACHE_TYPE = "q8_0";
    OLLAMA_CONTEXT_LENGTH = "32768";
    # Parallel slots would multiply the KV cache and overflow VRAM.
    OLLAMA_NUM_PARALLEL = "1";
    OLLAMA_MAX_LOADED_MODELS = "1";
    # Avoid reloading the model, cold loads are slow with 14GiB of RAM.
    OLLAMA_KEEP_ALIVE = "30m";
  };
in {
  home.packages = with pkgs; [
    # materialgram
    ollama-cuda
  ];

  home.sessionVariables = env;
  systemd.user.sessionVariables = env;

  wayland.windowManager.hyprland.extraConfig = ''
    local eDP = "${eDP}"
    local DP  = "${DP}"

    hl.monitor({
      output = "desc:" .. eDP,
      mode = "2560x1600@180.00Hz",
      position = "0x0",
      scale = 1.6,
      transform = 0,
    })

    for _, mon in ipairs(hl.get_monitors()) do
      if mon.description == DP then
        hl.workspace_rule({ workspace = "2", monitor = DP, default = true, })
        hl.workspace_rule({ workspace = "1", monitor = eDP, default = true, layout = "dwindle", })

        hl.monitor({
          output = "desc:" .. eDP,
          mode = "2560x1600@180.00Hz",
          position = "0x0",
          scale = 1.6,
          transform = 1,
        })

        hl.monitor({
          output = "desc:" .. DP,
          mode = "1920x1080@260.00Hz",
          position = "1000x0",
          scale = 1,
        })

        break
      end
    end
  '';
}
