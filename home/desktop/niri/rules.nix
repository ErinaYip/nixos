let
  mkWindowRule = match: properties:
    {
      matches = [match];
    }
    // properties;
in {
  window-rules =
    [
      {
        draw-border-with-background = false;
        opacity = 0.9;
        geometry-corner-radius = let
          r = 12.0;
        in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
      }

      (mkWindowRule
        {is-focused = true;}
        {opacity = 0.95;})

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
    ];
}
