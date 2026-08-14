{lib, ...}:
{
}
// lib.mkMerge (builtins.genList (
    i: let
      index = toString (i + 1);
      name = "No.${index}";
    in {
      workspaces.${name} = {};
      binds = {
        "Mod+${index}".action.focus-workspace = name;
        "Mod+Shift+${index}".action.move-window-to-workspace = name;
      };
    }
  )
  8)
