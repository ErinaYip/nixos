{
  plugins,
  themes,
}: {
  app = {
    alwaysUpdateLinks = true;
    livePreview = false;
    newLinkFormat = "shortest";
    promptDelete = false;
    showInlineTitle = true;
    showLineNumber = true;
    spellcheck = false;
    useMarkdownLinks = false;
    useTab = false;
    vimMode = false;
    attachmentFolderPath = "images";
    trashOption = "local";
    deleteUnlinkedAttachments = "always";
  };

  appearance = {
    baseFontSizeAction = true;
    accentColor = "";
    nativeMenus = false;
  };

  communityPlugins = [
    {
      pkg = plugins."better-export-pdf";
      settings = {
        prevConfig = {
          scale = 80;
          displayHeader = true;
          showTitle = false;
        };
      };
    }
    {
      pkg = plugins."editor-width-slider";
      settings = {
        sliderPercentage = "100";
      };
    }
    {
      pkg = plugins."novel-word-count";
      settings = {
        settings = {
          alignment = "right";
          showSameCountsOnFolders = false;
          folderCountType = "note";
        };
      };
    }
    {
      pkg = plugins."obsidian-icon-folder";
      settings = {
        settings = {
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
              icon = "LiBot";
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
            {
              rule = "Boot2Root";
              icon = "LiComputer";
              for = "everything";
              order = 10;
            }
          ];
        };
      };
    }
    {
      pkg = plugins."obsidian-style-settings";
      settings = {
        "Blue-Topaz-Codebox-Highlight@@code-line-number" = true;
      };
    }
  ];

  cssSnippets = [
    {
      name = "Blue Topaz - Stylix";
      source = ../../../assets/obsidian/blue-topaz-stylix.css;
    }
  ];

  themes = [
    {pkg = themes."Blue Topaz";}
  ];
}
