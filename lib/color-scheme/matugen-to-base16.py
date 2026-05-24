import argparse
import json
import subprocess
import sys


BASE16_MAP = {
    "base00": "surface_container",
    "base01": "surface_container_high",
    "base02": "surface_container_highest",
    "base03": "outline",
    "base04": "on_surface_variant",
    "base05": "on_background",
    "base06": "on_error_container",
    "base07": "on_tertiary_container",
    "base08": "error",
    "base09": "on_secondary_container",
    "base0A": "on_primary_container",
    "base0B": "primary",
    "base0C": "secondary",
    "base0D": "surface_tint",
    "base0E": "tertiary",
    "base0F": "tertiary_fixed_dim",
}


def main():
    parser = argparse.ArgumentParser(
        description="Create a base16 YAML file from matugen output"
    )
    _ = parser.add_argument("image", help="Image to generate the colors from")
    _ = parser.add_argument(
        "--name", "-n", required=True, help="Name of the color scheme"
    )
    _ = parser.add_argument(
        "--polarity", "-p", default="dark", choices=["dark", "light"]
    )
    _ = parser.add_argument(
        "--type", "-t", default="scheme-tonal-spot", help="Matugen scheme type"
    )
    _ = parser.add_argument(
        "--fallback-color",
        help="Color to use if matugen cannot extract one from the image",
    )
    _ = parser.add_argument(
        "--output", "-o", default="base16.yaml", help="Output YAML path"
    )
    args = parser.parse_args()

    def matugen_command(source):
        command = ["matugen"]
        command.extend(source)
        command.extend(
            [
                "--dry-run",
                "--source-color-index",
                "0",
                "--type",
                args.type,
                "--json",
                "hex",
            ]
        )
        return command

    source = (
        ["color", "hex", args.fallback_color]
        if args.fallback_color
        else ["image", args.image]
    )
    proc = subprocess.run(
        matugen_command(source), capture_output=True, text=True, check=False
    )
    if proc.returncode != 0 and not args.fallback_color:
        average = subprocess.run(
            [
                "magick",
                args.image,
                "-resize",
                "1x1!",
                "-format",
                "#%[hex:p{0,0}]",
                "info:",
            ],
            capture_output=True,
            text=True,
            check=False,
        )
        if average.returncode == 0:
            proc = subprocess.run(
                matugen_command(["color", "hex", average.stdout[:7]]),
                capture_output=True,
                text=True,
                check=False,
            )

    if proc.returncode != 0:
        sys.stderr.write(proc.stderr)
        return proc.returncode

    data = json.loads(proc.stdout)
    if "base16" in data:
        palette = {
            base16_name: f'"{data["base16"][base16_name.lower()][args.polarity]["color"]}"'
            for base16_name in BASE16_MAP
        }
    elif args.polarity in data["colors"]:
        colors = data["colors"][args.polarity]
        palette = {
            base16_name: f'"{colors[matugen_name].strip(chr(39))}"'
            for base16_name, matugen_name in BASE16_MAP.items()
        }
    else:
        colors = data["colors"]
        palette = {
            base16_name: f'"{colors[matugen_name][args.polarity]["color"]}"'
            for base16_name, matugen_name in BASE16_MAP.items()
        }

    yaml_content = (
        f'system: "base16"\n'
        f'name: "{args.name}"\n'
        f'author: "matugen"\n'
        f'variant: "{args.polarity}"\n'
        "palette:\n"
        + "\n".join(f"  {name}: {value}" for name, value in palette.items())
        + "\n"
    )

    with open(args.output, "w", encoding="utf-8") as output:
        output.write(yaml_content)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
