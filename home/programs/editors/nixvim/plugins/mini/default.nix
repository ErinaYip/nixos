{ ... }: {
  plugins.mini-pairs.enable = false;
  plugins.mini-pairs.settings.modes = {
    insert = true;
    command = false;
    terminal = false;
  };
}