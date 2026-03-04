let
  mkKeymap' = mode: key: action: desc: { silent ? true, noremap ? true }: {
    inherit mode key action;
    options = { inherit desc silent noremap; };
  };
in {
  mkKeymap = mkKeymap';
  mkKeymapd = mode: key: action: desc: mkKeymap' mode key action desc {};
  mkKeymapSimple = mode: key: action: mkKeymap' mode key action "" {};
}
