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

./homebrew.sh
./shell.sh
./languages.sh
./apps.sh
./github_ssh.sh

###################################################################

print_title "Restart"

ask_for_confirmation "Do you want to restart?"
if answer_is_yes; then
    sudo shutdown -r now &> /dev/null
fi
