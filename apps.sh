#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

print_title "Apps"

###################################################################

brew_install "Android SDK" "android-platform-tools"

brew_install "balenaEtcher" "balenaetcher"

brew_install "Docker" "docker"

brew_install "Dropbox" "dropbox"

brew_install "Google Chrome Beta" "google-chrome-beta" "homebrew/cask-versions"

brew_install "Google Drive" "google-drive"

brew_install "Iterm2" "iterm2"
execute \
    "defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string '$(pwd)/iterm2'" \
    "Iterm2: Specify the preferences directory"
execute \
    "defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true" \
    "Iterm2: Use the custom preferences directory"

brew_install "Keka" "keka"

brew_install "Logitech Options" "logitech-options"

brew_install "MonitorControl" "monitorcontrol"

brew_install "Skype" "skype"

brew_install "Spotify" "spotify"

brew_install "Transmission" "transmission"

brew_install "Ultimaker Cura" "ultimaker-cura"

brew_install "Visual Studio Code" "visual-studio-code"
brew_install "Font Fira Code" "font-fira-code" "homebrew/cask-fonts"

# if [[ $(brew cask list) != *prey* ]]; then
#     ask_without_echo "Please provide Prey API KEY (https://panel.preyproject.com/settings):" && printf "\n"
#     export HOMEBREW_NO_ENV_FILTERING=1 \
#         && export API_KEY="$(get_answer)" \
#         && brew_install "Prey" "prey"
# else
#     print_success "Prey"
# fi

brew_install "Zoom" "zoom"
