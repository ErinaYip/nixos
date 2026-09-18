{
  lib,
  pkgs,
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

    "deepseek-v4-flash"
    "deepseek-v4.1-flash-expires-on-0910"
  ]);

  ctf-skills = pkgs.fetchFromGitHub {
    owner = "ljagiello";
    repo = "ctf-skills";
    rev = "1af14f9030fee9da46014a8a3ed61a555b81ab98";
    sha256 = "sha256-v3JNLpd4JeeFdnXj219kT8BOOh+O7g/hTwaSwyIhubE=";
  };
in
  with eriniteLib;
    mkModule args {
      configFn = _: {
        xdg.configFile."pi/agent/skills/ctf-skills".source = ctf-skills;

        programs.pi-coding-agent = {
          enable = true;
          configDir = "${config.xdg.configHome}/pi/agent";

          settings = {
          };

          models = lib.mkMerge [
            (mkOpenAIProvider "hua" "https://huablog.org/v1")
            (mkOpenAIProvider "router" "https://anyrouter.top/v1")
          ];
        };
      };
    }
