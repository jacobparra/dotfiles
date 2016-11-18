#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

are_xcode_command_line_tools_installed() {
    xcode-select --print-path &> /dev/null
}

install_macos_updates_all() {

    # Install all available updates

    execute \
        "sudo softwareupdate --install --all" \
        "All updates"

}

install_macos_updates_recommended() {

    # Install only recommended available updates

    execute \
        "sudo softwareupdate --install --recommended" \
        "Recommended updates"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "   macOS Updates\n\n"

    install_macos_updates_all
    # install_macos_updates_recommended

}

main
