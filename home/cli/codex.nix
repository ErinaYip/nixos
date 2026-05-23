{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "cli";
  name = "codex";

  configFn = _: {
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

        model_providers = {
          freemodel = {
            name = "freemodel";
            base_url = "https://api.freemodel.dev/v1";
            env_key = "OPENAI_API_KEY";
          };
          rawchat = {
            name = "rawchat";
            base_url = "https://rawchat.cn/codex";
            wire_api = "responses";
            env_key = "OPENAI_API_KEY";
          };
          hua = {
            name = "hua";
            base_url = "https://huablog.ink";
            env_key = "OPENAI_API_KEY";
          };
          vespervei = {
            name = "vespervei";
            base_url = "https://api.vespervei.com/v1";
            env_key = "VESPERVEI_API_KEY";
          };
        };
      };
    };
  };
}
