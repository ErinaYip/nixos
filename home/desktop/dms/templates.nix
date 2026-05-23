{
  programs.kitty.extraConfig = "
    include dank-tabs.conf
    include dank-theme.conf
  ";

  gtk = {
    gtk3.extraCss = "@import url(\"dank-colors.css\");";
    gtk4.extraCss = "@import url(\"dank-colors.css\");";
  };
}
