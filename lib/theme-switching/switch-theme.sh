set -euo pipefail

current="$(cat /etc/erinite-theme/name 2>/dev/null || true)"

list_themes() {
  cat @themesFile@
}

usage() {
  printf '%s\n\n%s\n%s\n%s\n' \
    'Usage: erinite-theme-switch [theme]' \
    'Options:' \
    '  --current  print the active theme' \
    '  --list     list available themes'
}

case "${1-}" in
  --current)
    printf '%s\n' "$current"
    exit 0
    ;;
  --list)
    list_themes
    exit 0
    ;;
  -h|--help)
    usage
    exit 0
    ;;
esac

if [ "$#" -gt 1 ]; then
  usage >&2
  exit 64
fi

if [ "$#" -eq 1 ]; then
  choice="$1"
else
  exec dms ipc call dankdash wallpaper
fi

if ! grep -Fxq "$choice" @themesFile@; then
  printf 'Unknown theme: %s\n' "$choice" >&2
  exit 64
fi

if [ "$choice" = "$current" ]; then
  exit 0
fi

unit="$(systemd-escape --template=erinite-theme-switch@.service "$choice")"
systemctl start "$unit"
