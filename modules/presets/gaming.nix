{
  lib,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "presets";
  name = "gaming";

  configFn = { ... }: {
    erinite.programs = {
      gaming = enabled;
    };
  };
}
