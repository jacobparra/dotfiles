#!/bin/bash

# Ensure that the following actions
# are made relative to this file's path.
cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################
# Ask for the administrator password upfront.

sudo -v &> /dev/null

# Update existing `sudo` time stamp until this script has finished.
# https://gist.github.com/cowboy/3118588

while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done &> /dev/null &

###################################################################

# The role (personal/work) only picks the Brewfile; packages.sh asks for
# it when not given here.

./homebrew.sh
./packages.sh "$1"
./shell.sh
./tools.sh
./macos.sh
./github.sh

###################################################################

print_title "Done"

print_warning "Open a new terminal to load the new shell setup."
