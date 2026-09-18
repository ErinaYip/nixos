{pkgs}: let
  settings = import ./plugin-settings.nix;
  mkPlugin = {
    id,
    repo,
    version,
    hashes,
    tag ? version,
  }:
    pkgs.stdenvNoCC.mkDerivation {
      pname = "obsidian-plugin-${id}";
      inherit version;

      dontUnpack = true;

      installPhase = ''
        runHook preInstall
        install -Dm644 ${pkgs.fetchurl {
          url = "https://github.com/${repo}/releases/download/${tag}/manifest.json";
          hash = hashes.manifest;
        }} $out/manifest.json
        install -Dm644 ${pkgs.fetchurl {
          url = "https://github.com/${repo}/releases/download/${tag}/main.js";
          hash = hashes.main;
        }} $out/main.js
        install -Dm644 ${pkgs.fetchurl {
          url = "https://github.com/${repo}/releases/download/${tag}/styles.css";
          hash = hashes.styles;
        }} $out/styles.css
        runHook postInstall
      '';
    };

  packages = {
    better-export-pdf = mkPlugin {
      id = "better-export-pdf";
      repo = "l1xnan/obsidian-better-export-pdf";
      version = "2.0.3";
      tag = "2.0.3";
      hashes = {
        manifest = "sha256-JCDl2CICiRWtMtt1AYfRJPQzOzUS4gPvpRimGQDSxwk=";
        main = "sha256-PProP13Sko94mrI7sDGI0D5QJ6n1AAN9mxQu9u+s/DA=";
        styles = "sha256-0qigZwkp+PXw80cdMwgNkVvNPvHiRKzVShh6EIwzfCQ=";
      };
    };

    editor-width-slider = mkPlugin {
      id = "editor-width-slider";
      repo = "mugishomp/obsidian-editor-width-slider";
      version = "1.0.5";
      tag = "1.0.5";
      hashes = {
        manifest = "sha256-EEH5LxQBf5HdzDEQnH2+A/46Zzm610vFN9C9C3dy7mA=";
        main = "sha256-0/SWiiKJ8icXMOWhhB0zNhS/eD4nD16nQH3EwlZZkjI=";
        styles = "sha256-h2QkPK4DUevbt253DE/v/LGVb/QkINTsFZIS3HqFNe0=";
      };
    };

    novel-word-count = mkPlugin {
      id = "novel-word-count";
      repo = "isaaclyman/novel-word-count-obsidian";
      version = "4.6.0";
      tag = "4.6.0";
      hashes = {
        manifest = "sha256-Kg8pAWYenVDewZxsA649ICPitL+v9q02hJHynXqc25U=";
        main = "sha256-QvodWxoFt8qAeL4wlu84RjlF/dAFmTuwffuRdwtM4t4=";
        styles = "sha256-QWMQVhu3Aa3AWK1Vx1FRp3hoZ0xp19ahGVxa88hIVn4=";
      };
    };

    obsidian-icon-folder = mkPlugin {
      id = "obsidian-icon-folder";
      repo = "florianwoelki/obsidian-iconize";
      version = "2.14.7";
      tag = "2.14.7";
      hashes = {
        manifest = "sha256-9SShjWnpkKJEFzo1lWgcOaILy8ncGLWa9R5FZg/vXKI=";
        main = "sha256-raCwCXBlVsmBAflTpqh/XK/TABCF31k9O+KO7uohggE=";
        styles = "sha256-Vv/rg0n0r5fauKFPytywAZ07N7EW16NKoh6VjphFWok=";
      };
    };

    obsidian-style-settings = mkPlugin {
      id = "obsidian-style-settings";
      repo = "obsidian-community/obsidian-style-settings";
      version = "1.0.9";
      tag = "1.0.9";
      hashes = {
        manifest = "sha256-nP/cIM8qoTVIIOAFC2lLD5tXZEbj1dRKNq6LAYflv7g=";
        main = "sha256-GCirqs2rTFV4twWmJcWFswUS+O+tTHz8WhjnDMNVdGg=";
        styles = "sha256-7nk30r5QZTqJzLMK5fBXKyNQfVt/EyjQBScaNjB1v9g=";
      };
    };
  };
in {
  inherit packages;
  data = id: settings.${id};
}
