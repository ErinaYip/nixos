{
  "better-export-pdf" = {
    prevConfig = {
      pageSize = "A4";
      marginType = "1";
      showTitle = true;
      open = true;
      scale = 100;
      landscape = false;
      marginTop = "10";
      marginBottom = "10";
      marginLeft = "10";
      marginRight = "10";
      displayHeader = true;
      displayFooter = true;
      cssSnippet = "0";
    };
  };

  "editor-width-slider" = {
    sliderPercentage = "100";
  };

  "novel-word-count" = {
    settings = {
      alignment = "right";
      showSameCountsOnFolders = false;
      folderCountType = "note";
      folderCountConfig = {
        customSuffix = "n";
        "$sessionCountType" = "word";
      };
      showSameCountsOnRoot = false;
    };
  };

  "obsidian-icon-folder" = {
    settings = {
      migrated = 6;
      rules = [
        {
          rule = "MISC";
          icon = "LiPill";
          for = "everything";
          order = 0;
        }
        {
          rule = "PWN";
          icon = "LiAudioWaveform";
          for = "everything";
          order = 1;
        }
        {
          rule = "REVERSE";
          icon = "LiSearchCode";
          for = "everything";
          order = 2;
        }
        {
          rule = "WEB";
          icon = "LiEarth";
          for = "everything";
          order = 3;
        }
        {
          rule = "Game";
          icon = "LiFlag";
          for = "everything";
          order = 4;
        }
        {
          rule = "General";
          icon = "LiBookText";
          for = "everything";
          order = 5;
        }
        {
          rule = "Site";
          icon = "LiAlbum";
          for = "everything";
          order = 6;
        }
        {
          rule = "AI";
          icon = "LiComputer";
          for = "everything";
          order = 7;
        }
        {
          rule = "images";
          icon = "LiImage";
          for = "everything";
          order = 8;
        }
        {
          rule = "CRYPTO";
          icon = "LiLock";
          for = "everything";
          order = 9;
        }
      ];
      iconInTabsEnabled = true;
      iconInTitleEnabled = true;
    };
  };

  "obsidian-style-settings" = {
    "blue-topaz-theme@@left-ribbon-style" = "hide-left-ribbon-retention-drawer";
    "blue-topaz-theme@@bt-status-on" = false;
    "blue-topaz-theme@@scrollbar-style-option" = "default-scrollbar";
    "blue-topaz-theme@@simple-p-kanban" = false;
    "blue-topaz-theme@@remove-shadow-p-kanban" = false;
    "blue-topaz-theme@@layout-style-options" = "layout-style-options-default";
    "blue-topaz-theme@@toggle-header-bottom-line" = false;
    "blue-topaz-theme@@toggle-divider-lines" = false;
    "Blue-Topaz-Codebox-Highlight@@code-line-number" = true;
    "Blue-Topaz-Codebox-Highlight@@code-box-style-option" = "codebox-default-style";
    "blue-topaz-theme@@retain-header-color" = true;
  };
}
