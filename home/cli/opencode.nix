{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args: let
  mkProvider = name: npm: baseURL: models: {
    programs.opencode.settings.provider.${name} = {
      inherit npm name;
      options = {
        inherit baseURL;
        apiKey = "{env:${lib.strings.toUpper name}_API_KEY}";
      };
      models = lib.genAttrs models (_: {
        options = {
          reasoningEffort = "high";
          textVerbosity = "low";
          reasoningSummary = "auto";
        };
        variants = lib.genAttrs ["high" "xhigh"] (x: {
          reasoningEffort = x;
        });
      });
    };
  };

  mkOpenAIProvider = name: baseURL: (mkProvider name "@ai-sdk/openai" baseURL [
    "gpt-5.6-sol"
    "gpt-5.6-luna"
    "gpt-5.6-terra"
    "gpt-5.5"
    "gpt-5.4"
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
      configFn = _:
        lib.mkMerge [
          {
            programs.opencode = {
              enable = true;
              skills = {
                inherit ctf-skills;
              };
              settings = {
                autoupdate = false;
                permission = {
                  edit = "ask";
                  bash = "ask";
                };
                disabled_providers = ["openai" "gemini" "anthropic"];
              };
            };
          }

          (mkOpenAIProvider "hua" "https://huablog.xyz/v1")
          (mkOpenAIProvider "botcf" "https://botcf.com/v1")
        ];
    }
