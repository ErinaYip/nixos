{
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    lazyLoad.settings.ft = [
      "cpp"
      "c"
      "python"
      "nix"
    ];
  };
  plugins.lsp.servers = {
    clangd = {
      enable = true;
    };
    pyright = {
      enable = true;
    };
    nil_ls = {
      enable = false;
    };
    # nix profile install github:nix-community/nixd
    nixd = {
      enable = true;
    };
    qmlls = {
      enable = true;
    };
  };

  plugins.lsp.keymaps = {
    silent = true;
    lspBuf = {
      "<leader>gd" = {
        action = "definition";
        desc = "[G]oto [D]efinition";
      };
      "<leader>gr" = {
        action = "references";
        desc = "[G]oto [R]eferences";
      };
      "<leader>gD" = {
        action = "declaration";
        desc = "[G]oto [D]eclaration";
      };
      "<leader>gi" = {
        action = "implementation";
        desc = "[G]oto [I]mplementation";
      };
      "<leader>gt" = {
        action = "type_definition";
        desc = "[G]oto [T]ype Definition";
      };
      "<leader>cR" = {
        action = "rename";
        desc = "[C]ode [R]ename";
      };
      "<leader>ca" = {
        action = "code_action";
        desc = "[C]ode [A]ction";
      };
    };

    # diagnostic = {
    #   "<leader>cd" = {
    #     action = "open_float";
    #     desc = "打开当前行的诊断信息浮窗";
    #   };
    #   "[d" = {
    #     action = "goto_prev";
    #     desc = "跳转到上一个诊断";
    #   };
    #   "]d" = {
    #     action = "goto_next";
    #     desc = "跳转到下一个诊断";
    #   };
    # };
  };

  diagnostic.settings = {
    float.border = "rounded";
    # virtual_line.current_line = true;
    virtual_text = true;
    underline = true;
    update_in_insert = true;
    signs = true;
  };
}
