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
      pkg = plugins.packages."editor-width-slider";
      settings = plugins.data "editor-width-slider";
    }
    {
      pkg = plugins.packages."obsidian-icon-folder";
      settings = plugins.data "obsidian-icon-folder";
    }
    {
      pkg = plugins.packages."novel-word-count";
      settings.settings = (plugins.data "novel-word-count").settings;
    }
    {
      pkg = plugins.packages."obsidian-style-settings";
      settings = plugins.data "obsidian-style-settings";
    }
    {
      enable = false;
      pkg = plugins.packages."easy-typing-obsidian";
      settings = plugins.data "easy-typing-obsidian";
    }
    {
      enable = false;
      pkg = plugins.packages."obsidian-quiet-outline";
      settings = plugins.data "obsidian-quiet-outline";
    }
    {
      enable = false;
      pkg = plugins.packages."quick-explorer";
    }
  ];

  themes = [
    {pkg = themes.packages."Blue Topaz";}
  ];
}
