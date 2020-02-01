#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh" \

###################################################################

print_title "Setup NodeJS"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists "nvm"; then
    execute \
        "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh)" \
        "NVM"
else
    execute \
        "nvm_get_latest" \
        "NVM"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute \
    ". $HOME/.nvm/nvm.sh \
        && nvm install --lts" \
    "Node (LTS)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute \
    ". $HOME/.nvm/nvm.sh \
        && nvm_install_latest_npm" \
    "NPM"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "Yarn" "yarn --ignore-dependencies"

###################################################################

print_title "Setup Python"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "Pyenv" "pyenv"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "Pipenv" "pipenv"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Suggested build environment"

brew_install "openssl" "openssl"
brew_install "readline" "readline"
brew_install "sqlite3" "sqlite3"
brew_install "xz" "xz"
brew_install "zlib" "zlib"

###################################################################

print_title "Setup Ruby"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "rbenv" "rbenv"
