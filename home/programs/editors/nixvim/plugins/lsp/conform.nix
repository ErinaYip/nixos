{ ... }: {
  plugins.conform-nvim = {
    enable = true;
    lazyLoad.settings.ft = [ "c" "cpp" "python" "nix" ];
  };
  plugins.conform-nvim.autoInstall.enable = true;
  plugins.conform-nvim.settings = {
    notify_on_error = true;
    formatters_by_ft = {
      c = [ "clang_format" ];
      cpp = [ "clang_format" ];
      python = [ "black" ];
      nix = ["nixfmt"];
      qml = [ "qmlformat" ];
    };
  };
}
