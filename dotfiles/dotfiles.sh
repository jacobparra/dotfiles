#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_title "Dotfiles"

./create_symbolic_links.sh "$@"
./create_local_config_files.sh "$@"
