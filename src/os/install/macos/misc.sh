#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"

    brew_install "BeardedSpice" "beardedspice" "caskroom/cask" "cask"

    brew_install "Calibre" "calibre" "caskroom/cask" "cask"

    brew_install "Day-O" "day-o" "caskroom/cask" "cask"

    brew_install "Dropbox" "dropbox" "caskroom/cask" "cask"

    brew_install "Firefox" "firefox" "caskroom/cask" "cask"

    brew_install "Flux" "flux" "caskroom/cask" "cask"

    brew_install "Chrome Beta" "google-chrome-beta" "caskroom/versions" "cask"

    brew_install "Chrome Canary" "google-chrome-canary" "caskroom/versions" "cask"

    brew_install "Google Drive" "google-drive" "caskroom/cask" "cask"

    brew_install "Keka" "keka" "caskroom/cask" "cask"

    ask_without_echo "Please provide Prey API KEY (https://panel.preyproject.com/settings):" && printf "\n"
    export API_KEY="$(get_answer)" \
        && brew_install "Prey" "prey" "caskroom/cask" "cask"

    brew_install "Skype" "skype" "caskroom/cask" "cask"

    brew_install "Spectacle" "spectacle" "caskroom/cask" "cask"

    brew_install "Utorrent" "utorrent" "caskroom/cask" "cask"

    brew_install "VLC" "vlc" "caskroom/cask" "cask"

    brew_install "youtube-dl" "youtube-dl"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install developer friendly quick look plugins
    # see https://github.com/sindresorhus/quick-look-plugins
    print_in_purple "   Quick Look Plugins\n"

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

    print_in_purple "\n   Miscellaneous\n\n"

    install_apps
    printf "\n"

}

main
