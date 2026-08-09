let
  mkWindowRule = match: properties:
    {
      matches = [match];
    }
    // properties;
in {
  window-rules =
    [
      (mkWindowRule
        {app-id = "^(steam_app_.*)$";}
        {
          open-floating = true;
          opacity = 1.0;
        })

      (mkWindowRule
        {title = ".*float.*";}
        {
          open-floating = true;
          default-column-width.proportion = 0.6;
          default-window-height.proportion = 0.7;
        })

      (mkWindowRule
        {app-id = "^io[.]github[.]celluloid_player[.]Celluloid$";}
        {open-floating = true;})
    ]
    ++ map (title:
      mkWindowRule
      {inherit title;}
      {open-floating = true;}) [
      ".*图片和视频.*"
      ".*图片查看器.*"
      ".*视频播放器.*"
      ".*媒体查看器.*"
      ".*画中画.*"
      ".*打开文件.*"
      "好友列表"
    ];
}
