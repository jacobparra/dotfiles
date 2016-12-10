#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_macos_updates() {

    # Install all available updates

    execute \
        "sudo softwareupdate --install --all" \
        "Updating"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "   macOS Updates\n\n"

    install_macos_updates

}

main
