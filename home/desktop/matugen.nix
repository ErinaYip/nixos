{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    xdg.configFile."matugen/config.toml".text = ''
      [config]

      [templates.millennium]
      input_path = '${../../assets/matugen/millennium.css}'
      output_path = '~/.steam/steam/millennium/themes/Material-Theme/css/main/colors/matugen.css'
    '';
  };
}
