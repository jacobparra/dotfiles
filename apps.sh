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

brew_install "Ghostty" "ghostty"

brew_install "Visual Studio Code" "visual-studio-code"

brew_install "Docker Desktop" "docker-desktop"

brew_install "Postman" "postman"

# Productivity

brew_install "Google Chrome" "google-chrome"

brew_install "Claude" "claude"

brew_install "ClaudeMeter" "claudemeter" "eddmann/tap"

brew_install "Keka" "keka"

brew_install "Logi Options+" "logi-options+"

brew_install "MonitorControl" "monitorcontrol"

brew_install "OrcaSlicer" "orcaslicer"

###################################################################

# Installed by hand, on purpose — not part of the initial setup:
#
#   - Microsoft Teams (work account, installed manually)
#   - Raspberry Pi Imager: brew install raspberry-pi-imager
#
# Note: the silicon-labs-vcp-driver cask is no longer needed; macOS ships
# the native CP210x driver (AppleUSBSLCOM) since Big Sur.
