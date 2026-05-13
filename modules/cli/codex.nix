{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "cli";
    name = "codex";

    configFn = _: {
      erinite.home.programs.codex = {
        enable = true;
        settings = {
          model = "gpt-5.5";
          model_reasoning_effort = "medium";
          model_provider = "router";
          model_providers = {
            codeboy = {
              name = "codeboy";
              base_url = "https://api-be.codeboy.site/v1";
              env_key = "OPENAI_API_KEY";
            };
            router = {
              name = "router";
              base_url = "https://china.claudecoder.me/v1";
              env_key = "OPENAI_API_KEY";
            };
          };
        };
      };
    };
  }
