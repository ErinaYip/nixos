{eriniteLib, ...} @ args:
with eriniteLib;
  mkModule args {
    category = "cli";
    name = "opencode";

    configFn = _: {
      erinite.home.programs.opencode = {
        enable = true;
        settings = {
          model = "openai/gpt-5.5";
          provider = {
            openai = {
              options = {
                baseURL = "https://china.claudecoder.me/v1";
              };
            };
          };
        };
      };
    };
  }
