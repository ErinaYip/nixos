{ inputs, ... }: {
  imports = [ inputs.oh-my-rime-nix.homeModules.default ];
  
  programs.oh-my-rime.enable = true;
  programs.oh-my-rime.rimeConfig = {
    schema_list = [ { schema = "rime_mint"; } ];
  };
}

