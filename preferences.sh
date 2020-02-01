#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_title "macOS Preferences"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Dock"

execute "defaults write com.apple.dock persistent-apps -array" \
    "Wipe all app icons"
#         && defaults write com.apple.dock persistent-others -array " \

execute \
    "defaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>\"" \
    "Chrome icon"

execute \
    "defaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>\"" \
    "iTerm2 icon"

execute \
    "defaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>\"" \
    "Visual Studio Code icon"

execute \
    "defaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/TablePlus.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>\"" \
    "TablePlus icon"

execute \
    "defaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Postman.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>\"" \
    "Postman icon"

execute \
    "defaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>\"" \
    "Spotify icon"

execute \
    "defaults write com.apple.dock persistent-apps -array-add \"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>\"" \
    "Slack icon"

execute \
    "defaults write com.apple.dock autohide -bool true" \
    "Automatically hide/show the Dock"

execute \
    "defaults write com.apple.dock show-process-indicators -bool true" \
    "Show indicator lights for open applications"

execute \
    "defaults write com.apple.dock show-recents -bool false" \
    "Hide recent applications in Dock"

killall Dock &> /dev/null

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && \
         defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true" \
   "Avoid creating '.DS_Store' files on network or USB volumes"

execute "sudo defaults -currentHost write com.apple.systemuiserver dontAutoLoad -array \
            '/System/Library/CoreServices/Menu Extras/Clock.menu' \
            '/System/Library/CoreServices/Menu Extras/TimeMachine.menu' \
        && sudo defaults write com.apple.systemuiserver menuExtras -array \
            '/System/Library/CoreServices/Menu Extras/Battery.menu' \
            '/System/Library/CoreServices/Menu Extras/AirPort.menu' \
            '/System/Library/CoreServices/Menu Extras/Volume.menu' \
            '/System/Library/CoreServices/Menu Extras/Bluetooth.menu'
        " \
    "Hide Time Machine and Clock icons from the menu bar"

killall "SystemUIServer" &> /dev/null

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Keyboard"

execute "defaults write NSGlobalDomain 'InitialKeyRepeat_Level_Saved' -int 10" \
    "Set delay until repeat"

execute "defaults write NSGlobalDomain KeyRepeat -int 1" \
    "Set the key repeat rate to fast"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Finder"

execute "defaults write com.apple.finder ShowRecentTags -bool false" \
    "Do not show recent tags"

execute "defaults write NSGlobalDomain AppleShowAllExtensions -bool true" \
    "Show all filename extensions"

killall "Finder" &> /dev/null
