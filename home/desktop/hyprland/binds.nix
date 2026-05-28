{lib}: let
  raw = lib.generators.mkLuaInline;

  bindWithOpts = mods: dispatcher: opts: {
    _args = [
      mods
      (raw dispatcher)
      opts
    ];
  };
  bind = mods: dispatcher: bindWithOpts mods dispatcher {};

  directionName = {
    h = "left";
    l = "right";
    k = "up";
    j = "down";
  };
in {
  gesture = [
  ];

  bind =
    [
      (bindWithOpts "SUPER + mouse:272" "hl.dsp.window.drag()" {mouse = true;})
      (bindWithOpts "SUPER + mouse:273" "hl.dsp.window.resize()" {mouse = true;})

      (bind "SUPER + Q" "hl.dsp.window.close()")
      (bind "SUPER + A" ''hl.dsp.window.fullscreen({ mode = "maximized" })'')
      (bind "SUPER + F" ''hl.dsp.window.float({ action = "toggle" })'')
      (bind "SUPER + R" ''hl.dsp.layout("colresize +conf")'')
      (bind "SUPER + SHIFT + R" ''hl.dsp.layout("colresize -conf")'')
      (bind "Print" ''hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]])'')
      (bind "SUPER + S" ''hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]])'')
      (bind "SUPER + Print" ''hl.dsp.exec_cmd("grim - | wl-copy")'')

      (bind "SUPER + CTRL + R" ''hl.dsp.exec_cmd("hyprctl reload")'')
      (bind "SUPER + CTRL + E" "hl.dsp.exit()")

      (bind "SUPER + Return" ''hl.dsp.exec_cmd("kitty")'')
      (bind "SUPER + T" ''hl.dsp.exec_cmd("kitty --title=float")'')

      (bind "SUPER + B" ''hl.dsp.exec_cmd("firefox")'')
      (bind "SUPER + C" ''hl.dsp.exec_cmd("chromium")'')
      (bind "SUPER + D" ''hl.dsp.exec_cmd("fuzzel")'')
      (bind "SUPER + E" ''hl.dsp.exec_cmd("nemo")'')

      (bind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "r-1" })'')
      (bind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "r+1" })'')
      (bind "SUPER + P" ''hl.dsp.focus({ workspace = "r-1" })'')
      (bind "SUPER + N" ''hl.dsp.focus({ workspace = "r+1" })'')
      (bind "SUPER + minus" ''hl.dsp.focus({ workspace = "r-1" })'')
      (bind "SUPER + equal" ''hl.dsp.focus({ workspace = "r+1" })'')

      (bind "SUPER + SHIFT + mouse_up" ''hl.dsp.window.move({ workspace = "r-1" })'')
      (bind "SUPER + SHIFT + mouse_down" ''hl.dsp.window.move({ workspace = "r+1" })'')
      (bind "SUPER + SHIFT + P" ''hl.dsp.window.move({ workspace = "r-1" })'')
      (bind "SUPER + SHIFT + N" ''hl.dsp.window.move({ workspace = "r+1" })'')
      (bind "SUPER + SHIFT + minus" ''hl.dsp.window.move({ workspace = "r-1" })'')
      (bind "SUPER + SHIFT + equal" ''hl.dsp.window.move({ workspace = "r+1" })'')
    ]
    ++ (
      builtins.concatLists (builtins.genList (
          i: let
            ws = i + 1;
          in [
            (bind "SUPER + code:1${toString i}" "hl.dsp.focus({ workspace = ${toString ws} })")
            (bind "SUPER + SHIFT + code:1${toString i}" "hl.dsp.window.move({ workspace = ${toString ws} })")
          ]
        )
        9)
    )
    ++ (
      builtins.concatLists (map (x: [
          (bind "SUPER + ${x.key}" ''hl.dsp.focus({ direction = "${directionName.${x.dir}}" })'')
          (bind "SUPER + SHIFT + ${x.key}" ''hl.dsp.window.move({ direction = "${directionName.${x.dir}}" })'')
        ]) [
          {
            key = "H";
            dir = "h";
          }
          {
            key = "L";
            dir = "l";
          }
          {
            key = "K";
            dir = "k";
          }
          {
            key = "J";
            dir = "j";
          }
        ])
    );
}
