let
  bindWith = key: action: value: attrs: {
    name = key;
    value =
      attrs
      // {
        action.${action} = value;
      };
  };

  bind = key: action: (bindWith key action [] {});
  bindSpawn = key: command: (bindWith key "spawn" command {});
in {
  binds = builtins.listToAttrs (
    [
      (bind "Mod+Q" "close-window")
      (bind "Mod+R" "switch-preset-column-width")
      (bind "Mod+Shift+R" "switch-preset-column-width-back")
      (bind "Mod+A" "maximize-column")
      (bind "Mod+Shift+A" "fullscreen-window")
      (bind "Mod+F" "toggle-window-floating")

      (bind "Mod+S" "screenshot")
      (bind "Mod+Shift+S" "screenshot-window")
      (bind "Print" "screenshot")
      (bind "Mod+Print" "screenshot-window")

      (bindSpawn "Mod+Ctrl+R" ["niri" "msg" "action" "load-config-file"])
      (bindWith "Mod+Ctrl+E" "quit" {skip-confirmation = true;} {})

      (bindSpawn "Mod+Return" "kitty")
      (bindSpawn "Mod+T" ["kitty" "--title=float"])

      (bindSpawn "Mod+B" "firefox")
      (bindSpawn "Mod+C" "code")
      (bindSpawn "Mod+Shift+C" "chromium")
      (bindSpawn "Mod+D" "fuzzel")
      (bindSpawn "Mod+E" "nemo")

      (bindWith "Mod+WheelScrollUp" "focus-workspace-up" [] {cooldown-ms = 150;})
      (bindWith "Mod+WheelScrollDown" "focus-workspace-down" [] {cooldown-ms = 150;})
      (bind "Mod+P" "focus-workspace-up")
      (bind "Mod+N" "focus-workspace-down")
      (bind "Mod+Minus" "focus-workspace-up")
      (bind "Mod+Equal" "focus-workspace-down")

      (bindWith "Mod+Shift+WheelScrollUp" "move-window-to-workspace-up" [] {cooldown-ms = 150;})
      (bindWith "Mod+Shift+WheelScrollDown" "move-window-to-workspace-down" [] {cooldown-ms = 150;})
      (bind "Mod+Shift+P" "move-window-to-workspace-up")
      (bind "Mod+Shift+N" "move-window-to-workspace-down")
      (bind "Mod+Shift+Minus" "move-window-to-workspace-up")
      (bind "Mod+Shift+Equal" "move-window-to-workspace-down")
    ]
    ++ builtins.concatLists (builtins.genList (
        i: let
          workspace = i + 1;
          key = toString workspace;
        in [
          (bindWith "Mod+${key}" "focus-workspace" workspace {})
          (bindWith "Mod+Shift+${key}" "move-window-to-workspace" workspace {})
        ]
      )
      9)
    ++ builtins.concatLists (map (direction: [
        (bind "Mod+${direction.key}" direction.focus)
        (bind "Mod+Shift+${direction.key}" direction.move)
      ]) [
        {
          key = "H";
          focus = "focus-column-left";
          move = "move-column-left";
        }
        {
          key = "L";
          focus = "focus-column-right";
          move = "move-column-right";
        }
        {
          key = "K";
          focus = "focus-window-up";
          move = "move-window-up-or-to-workspace-up";
        }
        {
          key = "J";
          focus = "focus-window-down";
          move = "move-window-down-or-to-workspace-down";
        }
      ])
  );
}
