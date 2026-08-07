{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  defaultSettings =
    {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = true;

      character = {
        success_symbol = "[›](bold green) ";
        error_symbol = "[›](bold red) ";
      };

      directory = {
        read_only = " 󰌾";
      };

      battery = {
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        unknown_symbol = "󰂑 ";
        empty_symbol = "󰂎 ";
      };
    }
    // fromTOML ''
      [aws]
      symbol = " "

      [azure]
      symbol = " "

      [buf]
      symbol = " "

      [bun]
      symbol = " "

      [c]
      symbol = " "

      [cpp]
      symbol = " "

      [cmake]
      symbol = " "

      [cobol]
      symbol = " "

      [conda]
      symbol = " "

      [container]
      symbol = " "

      [crystal]
      symbol = " "

      [dart]
      symbol = " "

      [deno]
      symbol = " "

      [direnv]
      symbol = " "

      [docker_context]
      symbol = " "

      [dotnet]
      symbol = " "

      [elixir]
      symbol = " "

      [elm]
      symbol = " "

      [erlang]
      symbol = " "

      [fennel]
      symbol = " "

      [fortran]
      symbol = " "

      [fossil_branch]
      symbol = " "

      [gcloud]
      symbol = "󱇶 "

      [gleam]
      symbol = " "

      [git_branch]
      symbol = " "

      [git_commit]
      tag_symbol = '  '

      [golang]
      symbol = " "

      [gradle]
      symbol = " "

      [guix_shell]
      symbol = " "

      [haskell]
      symbol = " "

      [haxe]
      symbol = " "

      [helm]
      symbol = " "

      [hg_branch]
      symbol = " "

      [hostname]
      ssh_symbol = " "

      [java]
      symbol = " "

      [julia]
      symbol = " "

      [kotlin]
      symbol = " "

      [kubernetes]
      symbol = "󱃾 "

      [lua]
      symbol = " "

      [maven]
      symbol = " "

      [memory_usage]
      symbol = "󰍛 "

      [meson]
      symbol = "󰔷 "

      [mojo]
      symbol = "󰈸 "

      [nats]
      symbol = " "

      [netns]
      symbol = "󰛳 "

      [nim]
      symbol = " "

      [nix_shell]
      symbol = " "

      [nodejs]
      symbol = " "

      [ocaml]
      symbol = " "

      [odin]
      symbol = "󰟢 "

      [opa]
      symbol = " "

      [openstack]
      symbol = " "

      [package]
      symbol = "󰏗 "

      [perl]
      symbol = " "

      [php]
      symbol = " "

      [pijul_channel]
      symbol = " "

      [pixi]
      symbol = "󰏗 "

      [pulumi]
      symbol = " "

      [purescript]
      symbol = " "

      [python]
      symbol = " "

      [raku]
      symbol = "󱖊 "

      [red]
      symbol = "󱍼 "

      [rlang]
      symbol = "󰟔 "

      [ruby]
      symbol = " "

      [rust]
      symbol = "󱘗 "

      [scala]
      symbol = " "

      [shlvl]
      symbol = "󰹍 "

      [singularity]
      symbol = " "

      [solidity]
      symbol = " "

      [spack]
      symbol = " "

      [status]
      symbol = " "

      [sudo]
      symbol = " "

      [swift]
      symbol = " "

      [terraform]
      symbol = " "

      [vlang]
      symbol = " "

      [typst]
      symbol = " "

      [vagrant]
      symbol = " "

      [xmake]
      symbol = " "

      [zig]
      symbol = " "
    '';

  configFn = {settings, ...}: {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      inherit settings;
    };

    programs.yazi = {
      plugins = {
        "starship" = pkgs.yaziPlugins.starship;
      };
      initLua = lib.mkAfter ''
        require("starship"):setup()
      '';
    };
  };
}
