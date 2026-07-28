let
  mkRule = match: properties:
    {inherit match;} // properties;
in {
  window_rule =
    [
      (mkRule {class = "^(steam_app_.*)$";} {
        float = true;
        opacity = "1.0 override 1.0 override";
      })

      (mkRule {fullscreen = 1;} {
        opacity = "1.0 override 1.0 override";
      })

      (mkRule {initial_title = ".*float.*";} {
        float = true;
        size = ["60%" "70%"];
        center = true;
      })
    ]
    ++ map (title: mkRule {initial_title = title;} {float = true;}) [
      ".*图片和视频.*"
      ".*图片查看器.*"
      ".*视频播放器.*"
      ".*媒体查看器.*"
      ".*画中画.*"
      ".*打开文件.*"
      "io.github.celluloid_player.Celluloid"
    ];

  layer_rule = [
    {
      name = "blur-launcher";
      match.namespace = "^(launcher)$";
      blur = true;
    }
  ];
}
