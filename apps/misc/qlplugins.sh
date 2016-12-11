#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # Install developer friendly quick look plugins
    # see https://github.com/sindresorhus/quick-look-plugins

    brew_install "betterzipql" "betterzipql" "caskroom/cask" "cask"
    brew_install "qlcolorcode" "qlcolorcode" "caskroom/cask" "cask"
    brew_install "qlimagesize" "qlimagesize" "caskroom/cask" "cask"
    brew_install "qlmarkdown" "qlmarkdown" "caskroom/cask" "cask"
    brew_install "qlprettypatch" "qlprettypatch" "caskroom/cask" "cask"
    brew_install "qlstephen" "qlstephen" "caskroom/cask" "cask"
    brew_install "qlvideo" "qlvideo" "caskroom/cask" "cask"
    brew_install "quicklookapk" "quicklookapk" "caskroom/cask" "cask"
    brew_install "quicklookase" "quicklookase" "caskroom/cask" "cask"
    brew_install "quicklook-csv" "quicklook-csv" "caskroom/cask" "cask"
    brew_install "quicklook-json" "quicklook-json" "caskroom/cask" "cask"
    brew_install "suspicious-package" "suspicious-package" "caskroom/cask" "cask"
    brew_install "webpquicklook" "webpquicklook" "caskroom/cask" "cask"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_subtitle "Quick Look Plugins"

    install_apps

}

main
