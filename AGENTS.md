# AGENTS.md - Minimal Framework

## Quick commands

```bash
# Check/validate configuration
nix flake check .

# Enter dev shell
nix develop .
```

## Structure

- **flake.nix** - Flake with home-manager integration
- **lib/default.nix** - `lib.zenyte` (mkOpt, enabled, disabled, validFiles, etc.)
- **modules/** - Auto-imported via `lib.zenyte.validFiles`
- **hosts/** - Host-specific configurations

## Key patterns

- Use `enabled` / `disabled` instead of `true` / `false`
- Options use `demo.*` prefix (e.g., `demo.home`, `demo.cli.git`)
- Auto-import modules from `modules/` directory