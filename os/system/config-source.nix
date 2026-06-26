{
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    environment.shellAliases.nixos-source = "cd /run/current-system/configuration-source";

    system.systemBuilderCommands = ''
      ln -s ${inputs.self.outPath} $out/configuration-source
    '';
  };
}
