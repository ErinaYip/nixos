{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args: let
  tomlFormat = pkgs.formats.toml {};
  mkProviderWithOpts = name: base_url: opts: {
    erinite.home.cli = {
      zsh.aliases."codex-${name}" = "codex --profile ${name}";
      codex = {
        profileFiles.${name}.model_provider = name;
        model_providers.${name} =
          {
            inherit name base_url;
            env_key = "${lib.strings.toUpper name}_API_KEY";
          }
          // opts;
      };
    };
  };
  mkProvider = name: base_url: mkProviderWithOpts name base_url {};

  ctf-skills = pkgs.fetchFromGitHub {
    owner = "ljagiello";
    repo = "ctf-skills";
    rev = "1af14f9030fee9da46014a8a3ed61a555b81ab98";
    sha256 = "sha256-v3JNLpd4JeeFdnXj219kT8BOOh+O7g/hTwaSwyIhubE=";
  };
in
  with eriniteLib;
    mkModule args {
      opts = {
        profileFiles = mkAttrOpt lib.types.attrs {} "Codex profile config files.";
        model_providers = mkAttrOpt lib.types.attrs {} "Codex model_providers.";
      };

      configFn = {cfg, ...}: let
        mutableProfileFiles = lib.mapAttrs' (name: settings:
          lib.nameValuePair ".codex/${name}.config.toml" {
            source = tomlFormat.generate "${name}.config.toml" settings;
          })
        cfg.profileFiles;
      in
        lib.mkMerge [
          {
            programs.codex = {
              enable = true;
              skills = {
                inherit ctf-skills;
              };
              settings = {
                model = "gpt-5.5";
                model_reasoning_effort = "xhigh";
                network_access = true;
                disable_response_storage = true;
                model_instructions_file = ../../assets/codex/gpt-5.6-sol-unrestricted-v5.md;

                features = {
                  goals = true;
                  rmcp_client = true;
                  plan_tool = false;
                  view_image_tool = true;
                  parallel = true;

                  streamable_shell = true;
                  unified_exec = false;
                };

                experimental = {
                  use_freeform_apply_patch = true;
                };

                inherit (cfg) model_providers;
              };
            };

            home.activation.codexMutableProfileFiles = lib.hm.dag.entryAfter ["linkGeneration"] ''
              run mkdir -p "$HOME/.codex"

              ${lib.concatStrings (lib.mapAttrsToList (target: file: ''
                  if [[ -L "$HOME/${target}" ]]; then
                    target_link="$(readlink "$HOME/${target}")"
                    if [[ "$target_link" == /nix/store/* ]]; then
                      run rm "$HOME/${target}"
                    fi
                  fi

                  if [[ ! -e "$HOME/${target}" && ! -L "$HOME/${target}" ]]; then
                    run install -m 600 ${lib.escapeShellArg file.source} "$HOME/${target}"
                  fi
                '')
                mutableProfileFiles)}
            '';
          }

          (mkProvider "freemodel" "https://api.freemodel.dev/v1")
          (mkProvider "vespervei" "https://api.vespervei.com/v1")
          (mkProviderWithOpts "hua" "https://huablog.org/v1" {wire_api = "responses";})
          (mkProviderWithOpts "sixoner" "https://sub.sixoner.com" {wire_api = "responses";})
          (mkProviderWithOpts "rawchat" "https://rawchat.cn/codex" {wire_api = "responses";})
          (mkProviderWithOpts "botcf" "https://botcf.com/v1" {wire_api = "responses";})
        ];
    }
