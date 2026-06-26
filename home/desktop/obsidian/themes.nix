{pkgs}: {
  packages."Blue Topaz" = pkgs.stdenvNoCC.mkDerivation {
    pname = "obsidian-theme-blue-topaz";
    version = "2026060802";

    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      install -Dm644 ${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/pkm-er/Blue-Topaz_Obsidian-css/ecaf1b94d8a1b14cff7249e46c80ffc24e136a91/manifest.json";
        hash = "sha256-UjZkC9DF9GIKRWGuJ9pS7WasTTC8JoqRzqIRQzIK/co=";
      }} $out/manifest.json
      install -Dm644 ${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/pkm-er/Blue-Topaz_Obsidian-css/ecaf1b94d8a1b14cff7249e46c80ffc24e136a91/theme.css";
        hash = "sha256-qCSmhzv4syzbeDUNK1Gp+8rxXot1XYZqIOOCHT8TS5c=";
      }} $out/theme.css
      runHook postInstall
    '';
  };
}
