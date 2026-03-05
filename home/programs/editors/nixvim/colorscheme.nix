{ lib, ... }: {
  colorschemes.catppuccin.enable = false;

  extraConfigLua = ''
    pcall(function()
      require('noctalia').setup()
    end)
  '';

  # colorschemes.base16.enable = true;
  # extraConfigLua = ''
  #   pcall(function()
  #     require('matugen').setup()
  #   end)
  # '';
}
