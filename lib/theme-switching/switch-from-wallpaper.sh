set -euo pipefail

wallpaper="${1-}"
if [ -z "$wallpaper" ]; then
  exit 0
fi

file_name="$(basename -- "$wallpaper")"
theme=""

case "$file_name" in
@wallpaperCase@
esac

if [ -z "$theme" ]; then
  exit 0
fi

current="$(cat /etc/erinite-theme/name 2>/dev/null || true)"
if [ "$theme" = "$current" ]; then
  exit 0
fi

exec @themeSwitch@/bin/erinite-theme-switch "$theme"
