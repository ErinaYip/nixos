{ lib, ... }:
{
  # colorschemes.base16.enable = true;
  # extraConfigLua = ''
  #   require('matugen').setup()
  # '';

  extraConfigLua = lib.mkAfter ''
    local ok, noctalia = pcall(require, "noctalia")
    if ok then
      noctalia.setup()
    end
  '';
}
