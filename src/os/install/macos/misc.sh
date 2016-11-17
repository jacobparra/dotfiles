#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Chrome" "google-chrome" "caskroom/cask" "cask"
    brew_install "Chrome Canary" "google-chrome-canary" "caskroom/versions" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # brew_install "FFmpeg" "ffmpeg"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Firefox" "firefox" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # brew_install "Flash" "flash-npapi" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # brew_install "GIMP" "lisanet-gimp" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # brew_install "GPG" "gpg"
    # brew_install "GPG Agent" "gpg-agent"
    # brew_install "Pinentry" "pinentry-mac"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "ImageMagick" "imagemagick --with-webp"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "ShellCheck" "shellcheck"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Spectacle" "spectacle" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "tmux" "tmux"
    brew_install "tmux (pasteboard)" "reattach-to-user-namespace"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # brew_install "Transmission" "transmission" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Unarchiver" "the-unarchiver" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Vim" "vim --with-override-system-vi"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "VLC" "vlc" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_install "Web Font Tools: TTF/OTF → WOFF (Zopfli)" "sfnt2woff-zopfli" "bramstein/webfonttools"
    brew_install "Web Font Tools: TTF/OTF → WOFF" "sfnt2woff" "bramstein/webfonttools"
    brew_install "Web Font Tools: WOFF2" "woff2" "bramstein/webfonttools"

    #skype
    #slack
    #dropbox
    #google-drive
    # youtube-dl

    # Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Miscellaneous\n\n"

    install_apps
    printf "\n"
    brew_cleanup

}

main
