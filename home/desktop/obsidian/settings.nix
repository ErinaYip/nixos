{
  plugins,
  themes,
}: {
  app = {
    showLineNumber = true;
    livePreview = false;
    spellcheck = false;
    useTab = false;
    promptDelete = false;
    vimMode = false;
    newLinkFormat = "shortest";
    alwaysUpdateLinks = true;
    useMarkdownLinks = false;
    pdfExportSettings = {
      includeName = true;
      pageSize = "A4";
      landscape = false;
      margin = "0";
      downscalePercent = 100;
    };
    showInlineTitle = true;
  };

  appearance = {
    baseFontSizeAction = true;
    accentColor = "";
    nativeMenus = false;
  };

  communityPlugins = [
    {
      pkg = plugins.packages."better-export-pdf";
      settings = plugins.data "better-export-pdf";
    }
    {
      pkg = plugins.packages."editor-width-slider";
      settings = plugins.data "editor-width-slider";
    }
    {
      pkg = plugins.packages."obsidian-icon-folder";
      settings = plugins.data "obsidian-icon-folder";
    }
    {
      pkg = plugins.packages."novel-word-count";
      settings = plugins.data "novel-word-count";
    }
    {
      pkg = plugins.packages."obsidian-style-settings";
      settings = plugins.data "obsidian-style-settings";
    }
  ];

  themes = [
    {pkg = themes.packages."Blue Topaz";}
  ];
}
