import argparse
import json
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser(
        description="Create a base16 YAML file from matugen"
    )
    parser.add_argument("image", help="Image to generate the colors from")
    parser.add_argument("-n", "--name", required=True, help="Name of the color scheme")
    parser.add_argument("-p", "--polarity", default="dark", choices=["dark", "light"])
    parser.add_argument(
        "-o", "--output", default="base16.yaml", help="Output YAML path"
    )
    args = parser.parse_args()

    cmd = [
        "matugen",
        "--source-color-index",
        "0",
        "--dry-run",
        "--json",
        "hex",
        "image",
        args.image,
    ]

    proc = subprocess.run(cmd, capture_output=True, text=True)

    if proc.returncode != 0:
        sys.stderr.write(f"Matugen Error:\n{proc.stderr or proc.stdout}\n")
        return 1

    try:
        data = json.loads(proc.stdout)
        palette = {
            f"base{i:02X}": str(data["base16"][f"base{i:02x}"][args.polarity]["color"])
            for i in range(16)
        }
    except (json.JSONDecodeError, KeyError) as e:
        sys.stderr.write(f"Parse Error: {e}\n")
        return 1

    yaml_content = (
        f'system: "base16"\n'
        f'name: "{args.name}"\n'
        f'author: "matugen"\n'
        f'variant: "{args.polarity}"\n'
        "palette:\n" + "\n".join(f'  {k}: "{v}"' for k, v in palette.items()) + "\n"
    )

    with open(args.output, "w", encoding="utf-8") as f:
        f.write(yaml_content)

    return 0


if __name__ == "__main__":
    sys.exit(main())
