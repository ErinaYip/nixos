{
  lib,
  eriniteLib,
  ...
} @ args:

with eriniteLib; mkModule args {
  category = "cli";
  name = "codex";

  configFn = { ... }: {
    erinite.home.programs.codex = {
      enable = true;
      settings = {
        model = "gpt-5.4";
        model_provider = "codeboy";
        model_providers = {
          codeboy = {
            name = "codeboy";
            base_url = "https://api-be.codeboy.site/v1";
          };
        };
      };
    };
  };
}
