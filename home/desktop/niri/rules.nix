let
  mkWindowRule = match: properties: {
    window-rule._children = [
      {match._props = match;}
      properties
    ];
  };
in {
  _children =
    [
      {
        window-rule._children = [
          {
            draw-border-with-background = false;
            opacity = 0.9;
            geometry-corner-radius._args = [12.0 12.0 12.0 12.0];
            clip-to-geometry = true;
          }
        ];
      }

      (mkWindowRule
        {is-focused = true;}
        {opacity = 0.98;})

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
        {app-id = "^io.github.celluloid_player.Celluloid$";}
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
      "朋友圈"
      "语音聊天"
      "提取"
    ];
}
