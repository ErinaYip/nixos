{
  lib,
  pkgs,
  config,
  eriniteLib,
  ...
} @ args: let
  mkModel = modelDefaults: model: let
    cfg =
      if builtins.isString model
      then {id = model;}
      else model;
  in
    modelDefaults // cfg;

  mkProvider = {
    name,
    api,
    baseUrl,
    models,
    apiKey ? "\$${lib.strings.toUpper name}_API_KEY",
    modelDefaults ? {reasoning = true;},
    extra ? {},
  }: {
    providers.${name} =
      {
        inherit api baseUrl apiKey;
        models = map (mkModel modelDefaults) models;
      }
      // extra;
  };

  mkOpenAIProvider = name: baseUrl:
    mkProvider {
      inherit name baseUrl;
      api = "openai-completions";
      models = [
        "deepseek-v4.1-flash"
        "deepseek-v4-pro"

        "gpt-5.6-sol"
        "gpt-5.6-terra"
        "gpt-6-luna"
        "gpt-6-sol"
        "gpt-6-astra"
        "gpt-6.1-sol"

        "grok-4.6"
        "grok-4.7"
      ];
    };

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
            (mkProvider {
              name = "hua_cc";
              api = "anthropic-messages";
              baseUrl = "https://huablog.org/";
              models = [
                {
                  id = "claude-opus-5-5";
                  input = ["text" "image"];
                  contextWindow = 200000;
                  maxTokens = 128000;
                  compat = {
                    cacheControlFormat = "anthropic";
                    sendSessionAffinityHeaders = true;
                    forceAdaptiveThinking = true;
                    allowEmptySignature = true;
                  };
                }
              ];
            })
            (mkProvider {
              name = "ollama";
              api = "openai-completions";
              baseUrl = "http://127.0.0.1:11434/v1";
              apiKey = "ollama";
              # Local Ollama models are not declared as reasoning models.
              modelDefaults = {};
              extra.compat = {
                supportsDeveloperRole = false;
                supportsReasoningEffort = false;
              };
              models = [
                "qwen3.5:9b"
                {
                  id = "qwen3.5:9b-agent";
                  name = "Qwen3.5 9B Agent";
                  contextWindow = 32768;
                  maxTokens = 8192;
                }
              ];
            })
          ];
        };
      };
    }
