#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "Packages"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# The role only picks which Brewfile goes on top of the common one; it is
# not stored anywhere, so pass it again when re-running this script.

declare role="$1"

while [[ "$role" != "personal" && "$role" != "work" ]]; do
    ask "Which machine is this? (personal/work) "
    role="$(get_answer)"
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Not wrapped in `execute`: brew bundle can prompt for the sudo password
# (some casks run installers) and its progress is worth seeing.

print_subtitle "Brewfile + Brewfile.$role"

cat Brewfile "Brewfile.$role" | brew bundle --file=-

print_result $? "Packages ($role)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Homebrew's Compose plugin lives outside the paths docker searches. Link
# it in rather than editing ~/.docker/config.json, which also holds
# per-machine registry credentials.

declare -r COMPOSE_PLUGIN="$HOMEBREW_PREFIX/lib/docker/cli-plugins/docker-compose"

if [ -x "$COMPOSE_PLUGIN" ]; then
    mkdir -p "$HOME/.docker/cli-plugins"
    execute \
        "ln -sfn $COMPOSE_PLUGIN $HOME/.docker/cli-plugins/docker-compose" \
        "Docker Compose plugin"
fi
