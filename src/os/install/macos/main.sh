#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./os_updates.sh
./xcode.sh
./homebrew.sh
./bash.sh
# ./gnu.sh
# ./python.sh
# ./ruby.sh
# ./dev_tools.sh
# ./fonts.sh
./misc.sh
