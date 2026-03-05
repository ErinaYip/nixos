{ lib, ... }:
let
  nixFiles = builtins.filter
    (name: !builtins.elem name [ "keymap.nix" "default.nix" ])
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
}
