#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./updates.sh
./xcode.sh
./homebrew.sh
./core.sh
./bash.sh
./python.sh
./ruby.sh
./node.sh
./tools.sh
./misc.sh
./fonts.sh
