#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

update_macos() {

    # Install all available updates

    execute \
        "sudo softwareupdate --install --all" \
        "Update macOS"

    execute \
        "brew update" \
        "Homebrew (update)"

    execute \
        "brew upgrade" \
        "Homebrew (upgrade)"

}

update_ubuntu() {

    # Resynchronize the package index files from their sources.

    execute \
        "sudo apt-get update -qqy" \
        "APT (update)"

    # Install the newest versions of all packages installed.

    execute \
        "export DEBIAN_FRONTEND=\"noninteractive\" \
            && sudo apt-get -o Dpkg::Options::=\"--force-confnew\" upgrade -qqy" \
        "APT (upgrade)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_title "Update OS"
    printf "\n"

    update_macos
    # update_ubuntu

}

main
