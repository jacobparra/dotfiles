# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a macOS dotfiles repository for initial system setup. It installs and configures development tools, shell environment, and applications on a fresh Mac.

## Running Scripts

Full setup (runs all scripts in order):
```bash
./setup.sh
```

Individual scripts can be run separately:
```bash
./homebrew.sh      # Xcode CLI tools + Homebrew
./shell.sh      # Zsh + Oh-my-zsh + Powerlevel10k + symlinks
./languages.sh  # Node.js, Python, Ruby via asdf
./apps.sh       # macOS applications via Homebrew
./github_ssh.sh   # GitHub SSH key setup
```

## Architecture

### Key Files
- **utils.sh**: Shared utilities used by all scripts
  - `execute`: Runs commands in background with spinner (not suitable for interactive commands)
  - `brew_install`: Installs Homebrew formulas/casks
  - `cmd_exists`: Checks if a command is available
  - `print_*` / `ask_*`: UI helpers for colored output and user prompts

- **dotfiles/**: Configuration files symlinked to `$HOME`
  - `zshrc`, `p10k.zsh`: Shell configuration
  - `gitconfig`, `gitattributes`, `gitignore`: Git configuration
  - `ssh/config`: SSH configuration

- **iterm2/**: iTerm2 preferences (loaded via defaults)

## Important Notes

- The `execute` function runs commands in background without TTY access. Interactive commands (like Homebrew install) must be run directly.
- Apple Silicon Macs have Homebrew at `/opt/homebrew/bin/brew` (requires PATH setup).
- Language versions are managed via asdf (installs latest versions globally).
