#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

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

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_title "Miscellaneous"

    install_apps

}

main
