{
  lib,
  eriniteLib,
  ...
} @ args: let
  mkProviderWithOpts = name: base_url: opts: {
    erinite.home.cli = {
      zsh.aliases."codex-${name}" = "codex --profile ${name}";
      codex = {
        profiles.${name}.model_provider = name;
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
in
  with eriniteLib;
    mkModule args {
      namespace = ["erinite" "home"];
      category = "cli";
      name = "codex";

      opts = {
        profiles = mkAttrOpt lib.types.attrs {} "Codex profiles.";
        model_providers = mkAttrOpt lib.types.attrs {} "Codex model_providers.";
      };

      configFn = {cfg, ...}:
        lib.mkMerge [
          {
            programs.codex = {
              enable = true;
              settings = {
                model = "gpt-5.5";
                model_reasoning_effort = "medium";
                model_provider = "freemodel";

                sandbox_workspace_write.network_access = true;

                features = {
                  apply_patch_freeform = true;
                  plan_tool = true;
                  rmcp_client = true;
                  streamable_shell = false;
                  unified_exec = false;
                  view_image_tool = true;
                  web_search_request = true;
                  parallel = true;
                };

                experimental = {
                  use_freeform_apply_patch = true;
                  use_unified_exec_tool = true;
                };

                inherit (cfg) model_providers profiles;
              };
            };
          }

          (mkProvider "hua" "https://huablog.ink")
          (mkProvider "freemodel" "https://api.freemodel.dev/v1")
          (mkProvider "vespervei" "https://api.vespervei.com/v1")
          (mkProviderWithOpts "rawchat" "https://rawchat.cn/codex" {wire_api = "responses";})
        ];
    }
