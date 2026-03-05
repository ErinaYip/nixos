{ lib, ... }:
let
  nixFiles = builtins.filter
    (name: name != "default.nix")
    (builtins.attrNames (builtins.readDir ./.));

  mkServerConfig = file:
    let
      name = lib.removeSuffix ".nix" file;
      config = import (./. + "/${file}");
    in {
      ${name} = {
        enable = true;
        inherit config;
      };
    };

  serversConfig = builtins.foldl' 
    (acc: file: acc // (mkServerConfig file)) 
    {} 
    nixFiles;
in {
  lsp.servers = {
    "*" = {
      config = {
        capabilities = {
          textDocument = {
            semanticTokens = {
              multilineTokenSupport = true;
            };
          };
        };
        root_markers = [ ".git" ];
      };
    };
  } // serversConfig;

  diagnostic.settings = {
    virtual_text = true;
    float.source = true;
  };

  lsp.keymaps = [
    {
      key = "gd";
      lspBufAction = "definition";
    }
    {
      key = "gD";
      lspBufAction = "references";
    }
    {
      key = "gt";
      lspBufAction = "type_definition";
    }
    {
      key = "gi";
      lspBufAction = "implementation";
    }
    {
      key = "K";
      lspBufAction = "hover";
    }
    {
      action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
      key = "<leader>k";
    }
    {
      action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
      key = "<leader>j";
    }
    {
      action = "<CMD>LspStop<Enter>";
      key = "<leader>lx";
    }
    {
      action = "<CMD>LspStart<Enter>";
      key = "<leader>ls";
    }
    {
      action = "<CMD>LspRestart<Enter>";
      key = "<leader>lr";
    }
    {
      action = "<CMD>Lspsaga hover_doc<Enter>";
      key = "K";
    }
  ];
}
