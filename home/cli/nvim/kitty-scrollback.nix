{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; {
    kitty-scrollback = {
      package = kitty-scrollback-nvim;
      setup = "require('kitty-scrollback').setup()";
    };
  };
}
