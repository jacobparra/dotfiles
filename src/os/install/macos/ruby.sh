#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install ruby-build and rbenv
    brew install ruby-build
    brew install rbenv
    LINE='eval "$(rbenv init -)"'
    grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Ruby\n\n"

    install_apps
    printf "\n"

}

main
