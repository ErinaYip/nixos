# Point Limine's default menu entry at the system that is being installed.
#
# Limine's NixOS installer always writes `default_entry: 3`, which is the
# "Default" child of the newest generation. GRUB and systemd-boot instead derive
# the default entry from the toplevel handed to the bootloader installer, so a
# runtime switch to a specialisation survives a reboot while a plain system
# switch selects the plain generation again.
#
# This script is invoked from `boot.loader.limine.extraInstallCommands` in
# `os/desktop/theme-specialisations.nix`, that is after limine.conf has been
# generated, and rewrites `default_entry` to the first entry whose kernel
# command line boots the given toplevel. Limine counts entries in config order
# with submenus included, so the index is counted while walking the generated
# file. Nothing is changed when the toplevel has no entry in the menu.
#
# Usage: limine-default-entry.py <limine.conf> <toplevel>

import os
import sys


def main():
    conf_path = sys.argv[1]
    toplevel = sys.argv[2] if len(sys.argv) > 2 else ""
    if not toplevel:
        return 0

    init = "init=" + os.path.join(os.path.realpath(toplevel), "init")

    with open(conf_path) as conf:
        lines = conf.read().splitlines()

    index = 0
    current = None
    target = None

    for line in lines:
        if line.startswith("/"):
            index += 1
            current = index
        elif current is not None and target is None and line.startswith("cmdline:"):
            if init in line.split():
                target = current
                break

    if target is None:
        return 0

    updated = [
        "default_entry: %d" % target if line.startswith("default_entry:") else line
        for line in lines
    ]
    if updated == lines:
        return 0

    tmp_path = conf_path + ".tmp"
    with open(tmp_path, "w") as conf:
        conf.write("\n".join(updated) + "\n")
    os.replace(tmp_path, conf_path)

    return 0


sys.exit(main())
