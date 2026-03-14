{ ... }: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    binde = [
      ", XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
      ", XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
      ", XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
      ", XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"
      ", XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"

      # Dwindle resize widow
      "$mod ALT, h, resizeactive, -64 0"
      "$mod ALT, l, resizeactive, 64 0"
      "$mod ALT, k, resizeactive, 0 -64"
      "$mod ALT, j, resizeactive, 0 64"
    ];

    gesture = [
    ];

    bind = [
      # Window/Session
      "$mod, Q, killactive,"
      "$mod, F, fullscreen, 1"
      "$mod, Space, togglefloating,"
      "$mod, R, layoutmsg, colresize +conf"
      "$mod SHIFT, R, layoutmsg, colresize -conf"
      '', Print, exec, grim -g "$(slurp)" - | wl-copy''
      ''$mod, S, exec, grim -g "$(slurp)" - | wl-copy''

      # Terminal
      "$mod, Return, exec, kitty"
      "$mod, T, exec, kitty --title=float"

      # Applications
      "$mod, B, exec, firefox"
      "$mod, C, exec, chromium"
      "$mod, D, exec, fuzzel"
      # "$mod, E, exec, nemo"
      "$mod, E, exec, kitty yazi"

      # Noctalia
      "$mod, A, exec, noctalia-shell ipc call launcher toggle"
      "$mod, V, exec, noctalia-shell ipc call launcher clipboard"
      "$mod, m, exec, noctalia-shell ipc call sessionMenu toggle"
      "$mod, BackSpace, exec, noctalia-shell ipc call lockScreen lock"

      # Layout
      "$mod, F1, exec,  hyprctl keyword general:layout scrolling; notify-send -u normal '布局已切换' 'Scrolling'"
      "$mod, F2, exec,  hyprctl keyword general:layout dwindle; notify-send -u normal '布局已切换' 'Dwindle (BSPWM-like)'"  

      # move focus
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"
      "$mod, n, layoutmsg, promote"
      "$mod, Left, movefocus, l"
      "$mod, Right, movefocus, r"
      "$mod, Up, movefocus, u"
      "$mod, Down, movefocus, d"
      "$mod SHIFT, mouse_down, movefocus, l"
      "$mod SHIFT, mouse_up, movefocus, r"

      # move window
      "$mod SHIFT, Left, movewindow, l"
      "$mod SHIFT, Right, movewindow, r"
      "$mod SHIFT, Up, movewindow, u"
      "$mod SHIFT, Down, movewindow, d"
      "$mod SHIFT, h, movewindow, l"
      "$mod SHIFT, l, movewindow, r"
      "$mod SHIFT, k, movewindow, u"
      "$mod SHIFT, j, movewindow, d"

      # Workspace navigation
      "$mod, mouse_down, workspace, e-1"
      "$mod, mouse_up, workspace, e+1"
      # "$mod SHIFT, mouse_down, movetoworkspace, e-1"
      # "$mod SHIFT, mouse_up, movetoworkspace, e+1"
    ] ++ (
      builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 9)
    );
  };
}
