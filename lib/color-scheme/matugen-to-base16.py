#!/usr/bin/env python3
import argparse
import colorsys
import json
import subprocess
import sys
from pathlib import Path


def hex_to_rgb(s):
    s = s.strip().lstrip("#")
    if len(s) != 6:
        raise ValueError(f"Invalid hex color: {s}")
    return tuple(int(s[i : i + 2], 16) for i in (0, 2, 4))


def rgb_to_hex(rgb):
    return "#{:02x}{:02x}{:02x}".format(
        max(0, min(255, round(rgb[0]))),
        max(0, min(255, round(rgb[1]))),
        max(0, min(255, round(rgb[2]))),
    )


def hex_to_hls(s):
    r, g, b = hex_to_rgb(s)
    return colorsys.rgb_to_hls(r / 255, g / 255, b / 255)


def hls_to_hex(h, l, s):
    r, g, b = colorsys.hls_to_rgb(h % 1.0, max(0, min(1, l)), max(0, min(1, s)))
    return rgb_to_hex((r * 255, g * 255, b * 255))


def rel_luminance(hex_color):
    def channel(v):
        v /= 255
        return v / 12.92 if v <= 0.04045 else ((v + 0.055) / 1.055) ** 2.4

    r, g, b = hex_to_rgb(hex_color)
    return 0.2126 * channel(r) + 0.7152 * channel(g) + 0.0722 * channel(b)


def contrast(a, b):
    la, lb = rel_luminance(a), rel_luminance(b)
    hi, lo = max(la, lb), min(la, lb)
    return (hi + 0.05) / (lo + 0.05)


def mix(a, b, t):
    ar, ag, ab = hex_to_rgb(a)
    br, bg, bb = hex_to_rgb(b)
    return rgb_to_hex(
        (
            ar * (1 - t) + br * t,
            ag * (1 - t) + bg * t,
            ab * (1 - t) + bb * t,
        )
    )


def tune(hex_color, *, hue_shift=0.0, lightness=None, saturation=None, min_sat=0.35):
    h, l, s = hex_to_hls(hex_color)
    h = (h + hue_shift) % 1.0
    if lightness is not None:
        l = lightness
    if saturation is not None:
        s = saturation
    s = max(s, min_sat)
    return hls_to_hex(h, l, s)


def ensure_contrast(fg, bg, target=4.5):
    h, l, s = hex_to_hls(fg)

    # dark background: push foreground lighter
    if rel_luminance(bg) < 0.5:
        while contrast(hls_to_hex(h, l, s), bg) < target and l < 0.92:
            l += 0.03
    else:
        while contrast(hls_to_hex(h, l, s), bg) < target and l > 0.18:
            l -= 0.03

    return hls_to_hex(h, l, s)


def find_color(data, name, polarity):
    """
    Try to read matugen v4-ish JSON:
      data["colors"]["primary"]["dark"]["hex"] or ["color"]
    Also tolerate slightly different nesting.
    """
    colors = data.get("colors", {})

    candidates = [
        ("colors", name, polarity, "hex"),
        ("colors", name, polarity, "color"),
        ("colors", name, "default", "hex"),
        ("colors", name, "default", "color"),
        ("colors", name, "hex"),
        ("colors", name, "color"),
    ]

    for path in candidates:
        cur = data
        ok = True
        for key in path:
            if isinstance(cur, dict) and key in cur:
                cur = cur[key]
            else:
                ok = False
                break
        if ok and isinstance(cur, str) and cur.startswith("#"):
            return cur.lower()

    # Sometimes JSON may already be inside data["colors"].
    cur = colors.get(name)
    if isinstance(cur, str) and cur.startswith("#"):
        return cur.lower()

    raise KeyError(f"Cannot find color: {name}")


def fallback_color(data, name, polarity, fallback):
    try:
        return find_color(data, name, polarity)
    except KeyError:
        return fallback


def build_base16(data, polarity, style):
    # Material roles
    primary = fallback_color(data, "primary", polarity, "#7aa2f7")
    secondary = fallback_color(data, "secondary", polarity, "#bb9af7")
    tertiary = fallback_color(data, "tertiary", polarity, "#7dcfff")
    error = fallback_color(data, "error", polarity, "#f7768e")

    if polarity == "dark":
        bg = fallback_color(data, "surface", polarity, "#11111b")
        fg = fallback_color(data, "on_surface", polarity, "#cdd6f4")
        tint_to = "#ffffff"
        shade_to = "#000000"

        base00 = mix(bg, shade_to, 0.10)
        base01 = mix(bg, fg, 0.08)
        base02 = mix(bg, fg, 0.16)
        base03 = mix(bg, fg, 0.30)
        base04 = mix(bg, fg, 0.52)
        base05 = ensure_contrast(fg, base00, 7.0)
        base06 = mix(base05, tint_to, 0.12)
        base07 = mix(base05, tint_to, 0.28)

        normal_l = 0.68
        warm_l = 0.72

    else:
        bg = fallback_color(data, "surface", polarity, "#eff1f5")
        fg = fallback_color(data, "on_surface", polarity, "#4c4f69")
        tint_to = "#ffffff"
        shade_to = "#000000"

        base00 = mix(bg, tint_to, 0.18)
        base01 = mix(bg, fg, 0.08)
        base02 = mix(bg, fg, 0.15)
        base03 = mix(bg, fg, 0.35)
        base04 = mix(bg, fg, 0.55)
        base05 = ensure_contrast(fg, base00, 7.0)
        base06 = mix(base05, shade_to, 0.12)
        base07 = mix(base05, shade_to, 0.28)

        normal_l = 0.42
        warm_l = 0.45

    # style controls hue/saturation, not the gray ramp
    styles = {
        "balanced": {
            "sat": 0.50,
            "primary_shift": 0.00,
            "secondary_shift": 0.00,
            "tertiary_shift": 0.00,
        },
        "vivid": {
            "sat": 0.68,
            "primary_shift": 0.00,
            "secondary_shift": 0.04,
            "tertiary_shift": -0.04,
        },
        "soft": {
            "sat": 0.38,
            "primary_shift": 0.00,
            "secondary_shift": 0.02,
            "tertiary_shift": -0.02,
        },
        "analogous": {
            "sat": 0.52,
            "primary_shift": 0.00,
            "secondary_shift": 0.08,
            "tertiary_shift": -0.08,
        },
        "triad": {
            "sat": 0.56,
            "primary_shift": 0.00,
            "secondary_shift": 1 / 3,
            "tertiary_shift": -1 / 3,
        },
    }

    if style not in styles:
        raise ValueError(f"Unknown style: {style}")

    st = styles[style]
    sat = st["sat"]

    blue = tune(
        primary, hue_shift=st["primary_shift"], lightness=normal_l, saturation=sat
    )
    magenta = tune(
        secondary, hue_shift=st["secondary_shift"], lightness=normal_l, saturation=sat
    )
    cyan = tune(
        tertiary, hue_shift=st["tertiary_shift"], lightness=normal_l, saturation=sat
    )
    red = tune(error, lightness=warm_l, saturation=max(sat, 0.58))

    # Derive additional syntax colors from the image-related accents.
    green = tune(primary, hue_shift=0.27, lightness=normal_l, saturation=sat)
    yellow = tune(tertiary, hue_shift=0.13, lightness=warm_l, saturation=max(sat, 0.55))
    orange = tune(error, hue_shift=0.08, lightness=warm_l, saturation=max(sat, 0.60))
    brown = tune(
        secondary, hue_shift=-0.08, lightness=normal_l, saturation=max(0.35, sat - 0.10)
    )

    # Make sure syntax colors are readable on bg.
    accents = [red, orange, yellow, green, cyan, blue, magenta, brown]
    accents = [ensure_contrast(c, base00, 3.2) for c in accents]

    return {
        "base00": base00,
        "base01": base01,
        "base02": base02,
        "base03": base03,
        "base04": base04,
        "base05": base05,
        "base06": base06,
        "base07": base07,
        "base08": accents[0],
        "base09": accents[1],
        "base0A": accents[2],
        "base0B": accents[3],
        "base0C": accents[4],
        "base0D": accents[5],
        "base0E": accents[6],
        "base0F": accents[7],
    }


def run_matugen(image, index, scheme_type, polarity):
    cmd = [
        "matugen",
        "--source-color-index",
        str(index),
        "--dry-run",
        "--json",
        "hex",
        "-t",
        scheme_type,
        "image",
        image,
    ]

    proc = subprocess.run(cmd, capture_output=True, text=True)

    if proc.returncode != 0:
        sys.stderr.write(f"Matugen Error:\n{proc.stderr or proc.stdout}\n")
        sys.exit(1)

    try:
        return json.loads(proc.stdout)
    except json.JSONDecodeError as e:
        sys.stderr.write(f"Parse Error: {e}\n")
        sys.exit(1)


def write_base16(path, name, author, polarity, palette):
    yaml_content = (
        'system: "base16"\n'
        f'name: "{name}"\n'
        f'author: "{author}"\n'
        f'variant: "{polarity}"\n'
        "palette:\n" + "\n".join(f'  {k}: "{v}"' for k, v in palette.items()) + "\n"
    )

    Path(path).write_text(yaml_content, encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(
        description="Create a better base16 YAML file from matugen Material colors"
    )
    parser.add_argument("image", help="Image to generate the colors from")
    parser.add_argument("-n", "--name", required=True, help="Name of the color scheme")
    parser.add_argument("-i", "--index", default=0, type=int, help="Source color index")
    parser.add_argument("-p", "--polarity", default="dark", choices=["dark", "light"])
    parser.add_argument(
        "-t",
        "--type",
        default="scheme-tonal-spot",
        choices=[
            "scheme-content",
            "scheme-expressive",
            "scheme-fidelity",
            "scheme-fruit-salad",
            "scheme-monochrome",
            "scheme-neutral",
            "scheme-rainbow",
            "scheme-tonal-spot",
        ],
        help="matugen scheme type",
    )
    parser.add_argument(
        "-s",
        "--style",
        default="balanced",
        choices=["balanced", "vivid", "soft", "analogous", "triad"],
        help="base16 remapping style",
    )
    parser.add_argument("-o", "--output", default="base16.yaml")
    args = parser.parse_args()

    data = run_matugen(args.image, args.index, args.type, args.polarity)
    palette = build_base16(data, args.polarity, args.style)

    write_base16(
        args.output,
        args.name,
        f"matugen + custom {args.style}",
        args.polarity,
        palette,
    )

    return 0


if __name__ == "__main__":
    sys.exit(main())
