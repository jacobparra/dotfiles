#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "macOS preferences"

# On a managed Mac, IT profiles win over these: `defaults write` still
# succeeds, the managed value just takes precedence.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Dock"

execute \
    "defaults write com.apple.dock autohide -bool true && \
     defaults write com.apple.dock show-recents -bool false" \
    "Auto-hide, no recent apps"

# 1 means no action; the default (14) opens a Quick Note.
execute \
    "defaults write com.apple.dock wvous-br-corner -int 1 && \
     defaults write com.apple.dock wvous-br-modifier -int 0" \
    "No hot corner bottom-right"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Finder"

# The view style only applies to folders without a view of their own.
execute \
    "defaults write com.apple.finder FXPreferredViewStyle -string Nlsv" \
    "List view"

execute \
    "defaults write com.apple.finder NewWindowTarget -string PfHm && \
     defaults write com.apple.finder NewWindowTargetPath -string file://$HOME/" \
    "New windows open in the home folder"

execute \
    "defaults write NSGlobalDomain AppleShowAllExtensions -bool true && \
     defaults write com.apple.finder ShowPathbar -bool true && \
     defaults write com.apple.finder _FXSortFoldersFirst -bool true" \
    "Show extensions and path bar, folders first"

execute \
    "defaults write com.apple.finder FXDefaultSearchScope -string SCcf" \
    "Search the current folder"

execute \
    "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && \
     defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true" \
    "No .DS_Store on network and USB drives"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Keyboard and text"

# Takes effect after logging out.
execute \
    "defaults write NSGlobalDomain KeyRepeat -int 2 && \
     defaults write NSGlobalDomain InitialKeyRepeat -int 15" \
    "Fast key repeat"

execute \
    "defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false && \
     defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false" \
    "No auto-capitalization, no period on double space"

# Web views (Safari, Electron apps) read their own key.
execute \
    "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false && \
     defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false" \
    "No autocorrect"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Trackpad, appearance, screenshots"

# Tap to click: built-in and Bluetooth trackpads, plus the login screen.
execute \
    "defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true && \
     defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
     defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1" \
    "Tap to click"

execute \
    "defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true" \
    "Light/dark appearance follows the time of day"

execute \
    "defaults write com.apple.screencapture location -string $HOME/Downloads" \
    "Screenshots go to Downloads"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute \
    "killall Dock Finder SystemUIServer" \
    "Restart Dock, Finder and SystemUIServer"

print_warning "Key repeat and trackpad changes apply after logging out."
