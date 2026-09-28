{pkgs}: let
  fetchAddon = {
    name,
    addonId,
    url,
    hash,
  }:
    pkgs.fetchFirefoxAddon {
      inherit name url hash;
      fixedExtid = addonId;
    };
in {
  zeroomega = fetchAddon {
    name = "zeroomega-3.5.2";
    addonId = "suziwen1@gmail.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/5017630/zeroomega-3.5.2.xpi";
    hash = "sha256-plCYt2vK61MrpqrxA8ObPeCg2aT32IVeO6h/tAUuAe8=";
  };

  ublock-origin = fetchAddon {
    name = "ublock-origin-1.75.0";
    addonId = "uBlock0@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/5034826/ublock_origin-1.75.0.xpi";
    hash = "sha256-W3RBWGBFY3BkS9gPFhJehlsObDVrtd/PuEBpln6qUoc=";
  };

  auth-helper = fetchAddon {
    name = "auth-helper-8.0.2";
    addonId = "authenticator@mymindstorm";
    url = "https://addons.mozilla.org/firefox/downloads/file/4353166/auth_helper-8.0.2.xpi";
    hash = "sha256-26uRlHI330yFl/6hsA3OBc9/rqJ3Ij8sUQkPkUiBKmI=";
  };

  darkreader = fetchAddon {
    name = "darkreader-4.9.133";
    addonId = "addon@darkreader.org";
    url = "https://addons.mozilla.org/firefox/downloads/file/5055786/darkreader-4.9.133.xpi";
    hash = "sha256-6wbFCW12FhbH8dlUwRUkykv/T+cikETcH84oiowIU6s=";
  };
}
