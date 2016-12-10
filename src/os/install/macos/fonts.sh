#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Anonymous Pro" "font-anonymous-pro" "caskroom/fonts" "cask"

    brew_install "Droid Sans" "font-droid-sans" "caskroom/fonts" "cask"
    brew_install "Droid Sans Mono" "font-droid-sans-mono" "caskroom/fonts" "cask"

    brew_install "Inconsolata" "font-inconsolata" "caskroom/fonts" "cask"

    brew_install "Input" "font-input" "caskroom/fonts" "cask"

    brew_install "Office Code Pro" "font-office-code-pro" "caskroom/fonts" "cask"

    brew_install "Open Sans" "font-open-sans" "caskroom/fonts" "cask"

    brew_install "Pt Mono" "font-pt-mono" "caskroom/fonts" "cask"

    brew_install "Roboto" "font-roboto" "caskroom/fonts" "cask"

    brew_install "Source Code Pro" "font-source-code-pro" "caskroom/fonts" "cask"
    brew_install "Source Sans Pro" "font-source-sans-pro" "caskroom/fonts" "cask"

    brew_install "Ubuntu" "font-ubuntu" "caskroom/fonts" "cask"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Fonts\n\n"

    install_apps
    printf "\n"
    brew_cleanup

}

main
