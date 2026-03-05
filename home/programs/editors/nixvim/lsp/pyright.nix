{
  cmd = [ "pyright-langserver" "--stdio" ];
  filetypes = [ "python" ];
  python.analysis = {
    autoSearchPaths = true;
    useLibraryCodeForTypes = true;
    diagnosticMode = "openFilesOnly";
  };
}
