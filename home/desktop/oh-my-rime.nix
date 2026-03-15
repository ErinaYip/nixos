{ inputs, ... }: {
  imports = [ inputs.oh-my-rime-nix.homeModules.default ];
  
  programs.oh-my-rime.enable = true;
  programs.oh-my-rime.rimeConfig = {
    schema_list = [ { schema = "rime_mint"; } ];
  };
  programs.oh-my-rime.schemas = {
    "my_custom.schema.yaml" = {
      schema = {
        name = "My custom";
        description = "My Custom Double Pinyin";
      };
      switches = [{
        name = "ascii_mode";
        reset = 1;
        states = [ "中文" "英文" ];
      }];
    };
  };
}

