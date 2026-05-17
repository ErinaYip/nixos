{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "cli";
    name = "codex";

    configFn = _: {
      erinite.home.programs.codex = {
        enable = true;
        settings = {
          model = "gpt-5.4";
          model_reasoning_effort = "medium";
          model_provider = "rawchat";
          model_providers = {
            freemodel = {
              name = "freemodel";
              base_url = "https://api.freemodel.dev/v1";
              env_key = "OPENAI_API_KEY";
            };
            rawchat = {
              name = "rawchat";
              base_url = "https://rawchat.cn/codex";
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
