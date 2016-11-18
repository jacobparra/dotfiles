#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    echo_warn "Installing fonts..."
    brew cask install \
    font-anonymous-pro \
    font-dejavu-sans-mono-for-powerline \
    font-droid-sans \
    font-droid-sans-mono font-droid-sans-mono-for-powerline \
    font-meslo-lg font-input \
    font-inconsolata font-inconsolata-for-powerline \
    font-liberation-mono font-liberation-mono-for-powerline \
    font-liberation-sans \
    font-meslo-lg \
    font-nixie-one \
    font-office-code-pro \
    font-pt-mono \
    font-roboto \
    font-source-code-pro font-source-code-pro-for-powerline \
    font-source-sans-pro \
    font-ubuntu font-ubuntu-mono-powerline
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Fonts\n\n"

    install_apps
    printf "\n"

}

main
