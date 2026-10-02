# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Overview

This is a macOS dotfiles repository for initial system setup. It installs and configures development tools, shell environment, and applications on a fresh Mac.

## Running Scripts

Full setup (runs all scripts in order; the role picks the Brewfile and is asked for if omitted):
```bash
./setup.sh personal   # or: ./setup.sh work
```

Individual scripts can be run separately:
```bash
./homebrew.sh            # Xcode CLI tools + Homebrew
./packages.sh <role>     # brew bundle: Brewfile + Brewfile.<role>
./shell.sh               # Symlinks + per-machine *.local files
./tools.sh               # Node.js default via fnm + Claude Code (native installer)
./github.sh              # gh auth login (creates and uploads the SSH key)
```

## Architecture

Three layers:
- **Common**: everything versioned in this repo.
- **Per role** (`personal` / `work`): only `Brewfile.personal` / `Brewfile.work`. The role is a setup parameter and is not stored anywhere.
- **Per machine**: `~/.zshrc.local`, `~/.ssh/config.local`, `~/.gitconfig.local` — not versioned. Hosts, keys, tokens, the commit email and anything employer- or client-specific go here, because **this repo is public**.

### Key Files
- **utils.sh**: Shared utilities used by all scripts; also loads Homebrew's env so scripts find `brew` on a fresh Mac
  - `execute`: Runs commands in background with spinner (not suitable for interactive commands)
  - `cmd_exists`: Checks if a command is available
  - `print_*` / `ask_*`: UI helpers for colored output and user prompts

- **Brewfile**, **Brewfile.personal**, **Brewfile.work**: Homebrew packages, casks and Mac App Store apps (via `mas`). Apps installed by hand on purpose are listed as comments at the end of each file.

- **dotfiles/**: Configuration files symlinked into place by `shell.sh`
  - `zshrc`: Plain zsh (no oh-my-zsh) with Starship, fzf, fnm, zsh-autosuggestions and zsh-syntax-highlighting (all from Homebrew)
  - `starship.toml`: Prompt config, linked to `~/.config/starship.toml`
  - `gitconfig`, `gitattributes`, `gitignore`: Git configuration. `gitconfig` includes `~/.gitconfig.local` for the email and sets `useConfigOnly`
  - `ssh/config`: SSH configuration; includes `~/.ssh/config.local`
  - `ghostty/config`: Ghostty terminal configuration, linked to `~/.config/ghostty/config`
  - `*.local.example`: Templates copied to the per-machine files

- **bin/**: Personal scripts, symlinked into `~/.local/bin` (on the PATH via `zshrc`)
  - `archive-to-b2`: Uploads folders to Backblaze B2 with rclone, verifies SHA1, then offers to trash the local copy

## Important Notes

- The `execute` function runs commands in background without TTY access. Interactive commands (Homebrew install, `brew bundle`, `gh auth login`, prompts) must be run directly.
- Apple Silicon Macs have Homebrew at `/opt/homebrew/bin/brew` (requires PATH setup).
- Languages: Node.js via `fnm` (reads the `.nvmrc` / `.node-version` each repo commits); Python via `uv` (reads `.python-version`). No asdf.
- Git pushes over SSH; `gh` / `glab` are used for their APIs only, with no git credential helper.
- Most dotfiles are symlinked as `$HOME/.<name>`, but Ghostty and Starship read from `$XDG_CONFIG_HOME`, so `shell.sh` links them separately.
