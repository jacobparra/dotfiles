#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ "$(get_os)" == "macos" ]; then
    print_title "Setup macOS"

    ./xcode.sh
    ./homebrew.sh
fi
