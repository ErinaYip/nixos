{
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "system";
  name = "config-source";

  configFn = _: {
    environment.shellAliases.nixos-source = "cd /run/current-system/configuration-source";

    system.systemBuilderCommands = ''
      ln -s ${inputs.self.outPath} $out/configuration-source
    '';
  };
}
