set -eu

theme="${1:?missing theme name}"

case "$theme" in
  @themeCasePattern@) ;;
  *)
    echo "Unknown theme: $theme" >&2
    exit 64
    ;;
esac

for system in /nix/var/nix/profiles/system /run/current-system; do
  switcher="$system/specialisation/$theme/bin/switch-to-configuration"
  if [ -x "$switcher" ]; then
    exec "$switcher" switch
  fi
done

echo "No switchable specialisation found for theme: $theme" >&2
exit 69
