#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./os_updates.sh
./xcode.sh
./homebrew.sh
./bash.sh
./nvm.sh
./development.sh
./misc.sh
./fonts.sh
