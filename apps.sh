#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

print_title "Apps"

###################################################################

brew_install "Arduino" "arduino" "cask"

brew_install "BeardedSpice" "beardedspice" "cask"

brew_install "Calibre" "calibre" "cask"

brew_install "CH34x driver" "wch-ch34x-usb-serial-driver" "cask" "homebrew/cask-drivers"

brew_install "Chrome Beta" "google-chrome-beta" "cask" "homebrew/cask-versions"

brew_install "Day-O" "day-o" "cask"
execute \
    "defaults write -app Day-O \"format\" 'EEE MMM d  H:mm'" \
    "Day-O: date format"

brew_install "Docker" "docker" "cask"

brew_install "Dropbox" "dropbox" "cask"

brew_install "Fira Code" "font-fira-code" "cask" "homebrew/cask-fonts"

brew_install "Firefox" "firefox" "cask"

brew_install "Fritzing" "fritzing" "cask"

brew_install "Google Drive" "google-backup-and-sync" "cask"

brew_install "Iterm2" "iterm2" "cask"
execute \
    "defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string '$(pwd)/iterm2'" \
    "Iterm2: Specify the preferences directory"
execute \
    "defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true" \
    "Iterm2: Use the custom preferences directory"

brew_install "Java SE Development Kit" "java" "cask"

brew_install "Keka" "keka" "cask"

brew_install "Keybase" "keybase" "cask"

brew_install "Nerd Fonts" "font-hack-nerd-font" "cask" "homebrew/cask-fonts"

brew_install "OpenEmu" "openemu" "cask"

brew_install "Postman" "postman" "cask"

brew_install "Skype" "skype" "cask"

brew_install "Slack" "slack" "cask"

brew_install "Spectacle" "spectacle" "cask"

brew_install "Spotify" "spotify" "cask"

brew_install "TablePlus" "tableplus" "cask"

brew_install "Transmission" "transmission" "cask"
# execute "defaults write org.m0k.transmission DeleteOriginalTorrent -bool true" \
#     "Delete the original torrent files"
# execute "defaults write org.m0k.transmission DownloadAsk -bool false" \
#     "Don’t prompt for confirmation before downloading"
# execute "defaults write org.m0k.transmission MagnetOpenAsk -bool false" \
#     "Don’t prompt for confirmation before downloading for magnet links"
# execute "defaults write org.m0k.transmission DownloadChoice -string 'Constant' && \
#          defaults write org.m0k.transmission DownloadFolder -string '$HOME/Downloads'" \
#     "Use '~/Downloads' to store complete downloads"
# execute "defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true && \
#          defaults write org.m0k.transmission IncompleteDownloadFolder -string '$HOME/Downloads/torrents'" \
#     "Use '~/Downloads/torrents' to store incomplete downloads"
# execute "defaults write org.m0k.transmission WarningDonate -bool false" \
#     "Hide the donate message"
# execute "defaults write org.m0k.transmission WarningLegal -bool false" \
#     "Hide the legal disclaimer"

brew_install "Visual Studio Code" "visual-studio-code" "cask"

brew_install "VLC" "vlc" "cask"

if [[ $(brew cask list) != *prey* ]]; then
    ask_without_echo "Please provide Prey API KEY (https://panel.preyproject.com/settings):" && printf "\n"
    export HOMEBREW_NO_ENV_FILTERING=1 \
        && export API_KEY="$(get_answer)" \
        && brew_install "Prey" "prey" "cask"
else
    print_success "Prey"
fi
