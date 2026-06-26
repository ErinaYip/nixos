{
  pkgs,
  obsidianAssets,
}: let
  readJson = path: builtins.fromJSON (builtins.readFile path);
  pluginSrc = id: obsidianAssets + "/plugins/${id}";

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
    easy-typing-obsidian = mkPlugin {
      id = "easy-typing-obsidian";
      repo = "yaozhuwa/easy-typing-obsidian";
      version = "5.5.15";
      tag = "5.5.15";
      hashes = {
        manifest = "sha256-tXfH9gOO/p54WgiboyQ0pY70ZMUTL71fjIq4jsvEVe8=";
        main = "sha256-EjAimIEbUsq5zL9/v7MMSRdoLtHqhkCU9nuBddH4beY=";
        styles = "sha256-asGVbVWNQByECiRYSrASR1OLh+FOCFC9Mh+pXoxw/bQ=";
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

    obsidian-quiet-outline = mkPlugin {
      id = "obsidian-quiet-outline";
      repo = "guopenghui/obsidian-quiet-outline";
      version = "0.5.3";
      tag = "0.5.3";
      hashes = {
        manifest = "sha256-WTWNwFt3FKTlCRjFr5FbFQGZRkB6WArBGx5/bB5u7O8=";
        main = "sha256-C+bYme44Yop7q8I199ntEUkdQ9cjqSIjhG1uPxkKoaI=";
        styles = "sha256-G5E5UO5EpKAR2GqVxnY5X7r1aHQOaC4hFPbm2iAb3y4=";
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

    quick-explorer = mkPlugin {
      id = "quick-explorer";
      repo = "pjeby/quick-explorer";
      version = "0.2.14";
      tag = "0.2.14";
      hashes = {
        manifest = "sha256-83DtE/jp06WgZYRgg3wFUZ89dK8a6Q7p+SjgZsu2Q88=";
        main = "sha256-U0UzrvprFCfSOO57gAMpUtycTJbXxqHzHqHIWehm3VA=";
        styles = "sha256-7S59sDrak6GjX21Ey9jbjnoUFi/ic80xNA/R4qLdAjg=";
      };
    };
  };
in {
  inherit packages;
  data = id: readJson (pluginSrc id + "/data.json");
}
