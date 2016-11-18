#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Git" "git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Core casks
    brew cask install iterm2
    brew cask install java

    # Development tool casks
    brew cask install atom
    #postman
    #docker
    #pycharm
    #git
    #heroku-toolbelt

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Development tools\n\n"

    install_apps
    printf "\n"

}

main
