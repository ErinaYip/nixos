{
  "easy-typing-obsidian" = {
    Tabout = true;
    SelectionEnhance = true;
    IntrinsicSymbolPairs = true;
    BaseObEditEnhance = true;
    FW2HWEnhance = true;
    BetterCodeEdit = true;
    BetterBackspace = true;
    AutoFormat = true;
    ExcludeFiles = "";
    ChineseEnglishSpace = true;
    ChineseNumberSpace = true;
    EnglishNumberSpace = true;
    ChineseNoSpace = true;
    QuoteSpace = true;
    PunctuationSpace = true;
    AutoCapital = true;
    AutoCapitalMode = "typing";
    PunctuationSpaceMode = "typing";
    InlineCodeSpaceMode = 1;
    InlineFormulaSpaceMode = 1;
    InlineLinkSpaceMode = 1;
    InlineLinkSmartSpace = true;
    UserDefinedRegSwitch = true;
    UserDefinedRegExp = "{{.*?}}|++\n<.*?>|--\n\\[\\!.*?\\][-+]{0,1}|-+\n(file:///|https?://|ftp://|obsidian://|zotero://|www.)[^\\s（）《》。,，！？;；：“”‘’\\)\\(\\[\\]\\{\\}']+|--\n\n[a-zA-Z0-9_\\-.]+@[a-zA-Z0-9_\\-.]+|++\n(?<!#)#[\\u4e00-\\u9fa5\\w-\\/]+|++";
    debug = false;
    userSelRepRuleTrigger = ["-" "#"];
    userSelRepRuleValue = [
      {
        left = "~~";
        right = "~~";
      }
      {
        left = "#";
        right = " ";
      }
    ];
    userDeleteRulesStrList = [
      ["demo|" "|"]
    ];
    userConvertRulesStrList = [
      [":)|" "😀|"]
    ];
    userSelRuleSettingsOpen = true;
    userDelRuleSettingsOpen = true;
    userCvtRuleSettingsOpen = true;
    StrictModeEnter = false;
    StrictLineMode = "enter_twice";
    EnhanceModA = false;
    TryFixChineseIM = true;
    PuncRectify = false;
    FixMacOSContextMenu = false;
    TryFixMSIME = false;
    CollapsePersistentEnter = false;
  };

  "editor-width-slider" = {
    sliderPercentage = "100";
    sliderPercentageDefault = "20";
    sliderWidth = "150";
  };

  "novel-word-count" = {
    settings = {
      useAdvancedFormatting = false;
      countType = "word";
      countConfig = {
        customSuffix = "w";
        "$sessionCountType" = "word";
      };
      countType2 = "none";
      countConfig2 = {
        "$sessionCountType" = "word";
      };
      countType3 = "none";
      countConfig3 = {
        "$sessionCountType" = "word";
      };
      pipeSeparator = "|";
      abbreviateDescriptions = false;
      alignment = "right";
      showSameCountsOnFolders = false;
      folderCountType = "note";
      folderCountConfig = {
        customSuffix = "n";
        "$sessionCountType" = "word";
      };
      folderCountType2 = "none";
      folderCountConfig2 = {
        "$sessionCountType" = "word";
      };
      folderCountType3 = "none";
      folderCountConfig3 = {
        "$sessionCountType" = "word";
      };
      folderPipeSeparator = "|";
      folderAbbreviateDescriptions = false;
      folderAlignment = "inline";
      showSameCountsOnRoot = false;
      rootCountType = "word";
      rootCountConfig = {
        customSuffix = "w";
        "$sessionCountType" = "word";
      };
      rootCountType2 = "none";
      rootCountConfig2 = {
        "$sessionCountType" = "word";
      };
      rootCountType3 = "none";
      rootCountConfig3 = {
        "$sessionCountType" = "word";
      };
      rootPipeSeparator = "|";
      rootAbbreviateDescriptions = false;
      showAdvanced = false;
      labelOpacity = 0.75;
      wordsPerMinute = 265;
      charsPerMinute = 500;
      wordsPerPage = 300;
      charsPerPage = 1500;
      charsPerPageIncludesWhitespace = false;
      characterCountType = "AllCharacters";
      pageCountType = "ByWords";
      includeDirectories = "";
      excludeComments = false;
      excludeCodeBlocks = false;
      excludeNonVisibleLinkPortions = false;
      excludeFootnotes = false;
      momentDateFormat = "";
      debugMode = false;
    };
  };

  "obsidian-icon-folder" = {
    settings = {
      migrated = 6;
      iconPacksPath = ".obsidian/icons";
      fontSize = 16;
      emojiStyle = "native";
      iconColor = null;
      recentlyUsedIcons = [];
      recentlyUsedIconsSize = 5;
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
      extraMargin = {
        top = 0;
        right = 4;
        bottom = 0;
        left = 0;
      };
      iconInTabsEnabled = true;
      iconInTitleEnabled = true;
      iconInTitlePosition = "above";
      iconInFrontmatterEnabled = false;
      iconInFrontmatterFieldName = "icon";
      iconColorInFrontmatterFieldName = "iconColor";
      iconsBackgroundCheckEnabled = false;
      iconsInNotesEnabled = true;
      iconsInLinksEnabled = true;
      iconIdentifier = ":";
      lucideIconPackType = "native";
      debugMode = false;
      useInternalPlugins = false;
    };
  };

  "obsidian-quiet-outline" = {
    search_support = true;
    level_switch = true;
    markdown = true;
    expand_level = "0";
    hide_unsearched = true;
    auto_expand_ext = "only-expand";
    regex_search = false;
    ellipsis = false;
    label_direction = "left";
    drag_modify = false;
    locate_by_cursor = false;
    show_popover_key = "ctrlKey";
    persist_md_states = true;
    keep_search_input = false;
    export_format = "{title}";
    lang_direction_decide_by = "system";
    auto_scroll_into_view = true;
    vimlize_canvas = true;
    canvas_sort_by = "area";
    patch_color = true;
    primary_color_light = "#18a058";
    primary_color_dark = "#63e2b7";
    rainbow_line = false;
    rainbow_color_1 = "#FD8B1F";
    rainbow_color_2 = "#FFDF00";
    rainbow_color_3 = "#07EB23";
    rainbow_color_4 = "#2D8FF0";
    rainbow_color_5 = "#BC01E2";
    font_size = "";
    font_family = "";
    font_weight = "";
    line_height = "";
    line_gap = "";
    custom_font_color = false;
    h1_color = "#000000";
    h2_color = "#000000";
    h3_color = "#000000";
    h4_color = "#000000";
    h5_color = "#000000";
    h6_color = "#000000";
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
