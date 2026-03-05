{ lib, ... }: {
  colorschemes.catppuccin.enable = false;

  extraConfigLua = lib.mkAfter ''
    local ok, noctalia = pcall(require, "noctalia")
    if ok then
      noctalia.setup()
    end
  '';
}
