#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

print_title "Apps"

###################################################################

# Dev Tools

brew_install "Font Hack Nerd" "font-hack-nerd-font"
brew_install "Font Fira Code" "font-fira-code"

brew_install "Iterm2" "iterm2"
execute \
    "defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string '$(pwd)/iterm2'" \
    "Iterm2: Specify the preferences directory"
execute \
    "defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true" \
    "Iterm2: Use the custom preferences directory"

brew_install "Visual Studio Code" "visual-studio-code"

brew_install "Docker Desktop" "docker-desktop"

brew_install "Postman" "postman"

brew_install "Raspberry Pi Imager" "raspberry-pi-imager"

brew_install "Android Platform Tools" "android-platform-tools"

brew_install "Silicon Labs Driver" "silicon-labs-vcp-driver"

# Productivity

brew_install "Google Chrome" "google-chrome"

brew_install "Google Drive" "google-drive"

brew_install "Claude" "claude"

brew_install "Keka" "keka"

brew_install "Logitech Options" "logitech-options"

brew_install "MonitorControl" "monitorcontrol"

brew_install "OrcaSlicer" "orcaslicer"

# Entertainment

brew_install "Spotify" "spotify"

brew_install "VLC" "vlc"

brew_install "Transmission" "transmission"

# Communication

brew_install "Zoom" "zoom"

brew_install "Telegram" "telegram"
