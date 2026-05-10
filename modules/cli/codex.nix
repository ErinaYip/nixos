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
          model_provider = "xem";
          model_providers = {
            codeboy = {
              name = "codeboy";
              base_url = "https://api-be.codeboy.site/v1";
            };
            xem = {
              name = "xem";
              base_url = "http://new.xem8k5.top:3000/v1";
            };
          };
        };
      };
    };
  }
