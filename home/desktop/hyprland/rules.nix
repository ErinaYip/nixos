{
  window_rule = [
    {
      name = "opaque-fullscreen";
      match.fullscreen = 1;
      opacity = "1.0 override 1.0 override";
    }
    {
      name = "opaque-steam-games";
      match.class = "^(steam_app_.*)$";
      opacity = "1.0 override 1.0 override";
    }

    {
      name = "float-title-float";
      match.initial_title = ".*float.*";
      float = true;
    }
    {
      name = "float-title-images-and-video";
      match.initial_title = ".*图片和视频.*";
      float = true;
    }
    {
      name = "float-title-image-viewer";
      match.initial_title = ".*图片查看器.*";
      float = true;
    }
    {
      name = "float-title-video-player";
      match.initial_title = ".*视频播放器.*";
      float = true;
    }
    {
      name = "float-title-media-viewer";
      match.initial_title = ".*媒体查看器.*";
      float = true;
    }
    {
      name = "float-title-picture-in-picture";
      match.initial_title = ".*画中画.*";
      float = true;
    }
    {
      name = "float-title-open-file";
      match.initial_title = ".*打开文件.*";
      float = true;
    }
  ];

  layer_rule = [
    {
      name = "blur-launcher";
      match.namespace = "^(launcher)$";
      # opacity = "0.8 override 0.8 override";
      blur = true;
    }
  ];
}
