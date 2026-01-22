#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "Setup Homebrew and Xcode Command Line Tools"

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
    print_subtitle "Installing Homebrew (requires sudo)..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_result $? "Homebrew (install)"

    # Add brew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    print_success "Homebrew (already installed)"
fi

execute \
    "brew update" \
    "Homebrew (update)"
