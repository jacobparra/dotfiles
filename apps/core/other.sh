#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # Other utilities

    brew_install "GPG" "gpg"
    brew_install "GPG Agent" "gpg-agent"
    brew_install "htop" "htop --with-ncurses"
    brew_install "ImageMagick" "imagemagick --with-webp"
    brew_install "shellcheck" "shellcheck"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_subtitle "Other utils"

    install_apps

}

main
