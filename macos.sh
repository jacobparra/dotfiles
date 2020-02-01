#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "Setup macOS"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Xcode Command Line Tools

xcode-select --install &> /dev/null

# Wait until the `Xcode Command Line Tools` are installed.
execute \
    "until xcode-select --print-path &> /dev/null; do \
        sleep 5; \
        done" \
    "Xcode Command Line Tools"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install homebrew

if ! cmd_exists "brew"; then
    printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
    #  └─ simulate the ENTER keypress
fi
print_result $? "Homebrew"

execute \
    "brew update" \
    "Homebrew (update)"
