#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Atom" "atom" "caskroom/cask" "cask"

    brew_install "Arduino" "arduino" "caskroom/cask" "cask"

    brew_install "Docker" "docker" "caskroom/cask" "cask"

    brew_install "Iterm2" "iterm2" "caskroom/cask" "cask"

    brew_install "Postman" "postman" "caskroom/cask" "cask"

    brew_install "VirtualBox" "virtualbox" "caskroom/cask" "cask"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Development tools\n\n"

    install_apps
    printf "\n"

}

main
