{
  lib,
  config,
  eriniteLib,
  ...
} @ args: let
  mkProvider = name: api: baseUrl: models: {
    providers.${name} = {
      inherit api baseUrl;
      apiKey = "\$${lib.strings.toUpper name}_API_KEY";
      models =
        map (model: {
          id = model;
          reasoning = true;
        })
        models;
    };
  };

  mkOpenAIProvider = name: baseUrl: (mkProvider name "openai-completions" baseUrl [
    "gpt-5.6-sol"
    "gpt-5.6-luna"
    "gpt-5.6-terra"
    "gpt-5.5"
    "gpt-5.4"
  ]);
in
  with eriniteLib;
    mkModule args {
      configFn = _: {
        programs.pi-coding-agent = {
          enable = true;
          configDir = "${config.xdg.configHome}/pi/agent";
          # context = ../../assets/codex/gpt5.5-unrestricted.md;

          settings = {
          };

          models = lib.mkMerge [
            (mkOpenAIProvider "hua" "https://huablog.org/v1")
            (mkOpenAIProvider "router" "https://anyrouter.top/v1")
          ];
        };
      };
    }
