{
  "$mod" = "SUPER";

  bindm = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];

  gesture = [
  ];

  bind =
    [
      # Window/Session
      "$mod, Q, killactive,"
      "$mod, A, fullscreen, 1"
      "$mod, F, togglefloating,"
      "$mod, R, layoutmsg, colresize +conf"
      "$mod SHIFT, R, layoutmsg, colresize -conf"
      '', Print, exec, grim -g "$(slurp)" - | wl-copy''
      ''$mod, S, exec, grim -g "$(slurp)" - | wl-copy''

      "$mod, Return, exec, kitty"
      "$mod, T, exec, kitty --title=float"

      "$mod, B, exec, firefox"
      "$mod, C, exec, chromium"
      "$mod, D, exec, fuzzel"
      "$mod, E, exec, nemo"

      "$mod, mouse_down, workspace, r-1"
      "$mod, mouse_up, workspace, r+1"
    ]
    ++ (
      builtins.concatLists (builtins.genList (
          i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
    )
    ++ (
      builtins.concatLists (map (x: [
          "$mod, ${x.key}, movefocus, ${x.dir}"
          "$mod SHIFT, ${x.key}, movewindow, ${x.dir}"
        ]) [
          {
            key = "H";
            dir = "l";
          }
          {
            key = "L";
            dir = "r";
          }
          {
            key = "K";
            dir = "u";
          }
          {
            key = "J";
            dir = "d";
          }
        ])
    );
}
