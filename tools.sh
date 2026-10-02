#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "Setup tools"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Node: fnm switches versions from each repo's .nvmrc on cd, so projects
# pin their own; the default, used everywhere else, is the current LTS.
# Python needs no setup: uv fetches the version a project's
# .python-version asks for.

print_subtitle "Node.js"

execute \
    "fnm install --lts && fnm default lts-latest" \
    "Node.js LTS (fnm default)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Claude Code: the native installer rather than the Homebrew cask, as it
# keeps itself up to date. It lands in ~/.local/bin.

print_subtitle "Claude Code"

if [ -x "$HOME/.local/bin/claude" ]; then
    print_success "Claude Code (already installed)"
else
    execute \
        "curl -fsSL https://claude.ai/install.sh | bash" \
        "Claude Code"
fi
