#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Firefox" "firefox" "caskroom/cask" "cask"

    brew_install "Chrome Beta" "google-chrome-beta" "caskroom/versions" "cask"

    brew_install "Chrome Canary" "google-chrome-canary" "caskroom/versions" "cask"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_subtitle "Browsers"

    install_apps

}

main
