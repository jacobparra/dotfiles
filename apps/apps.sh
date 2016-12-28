#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./update.sh

./core/core.sh
./fonts/fonts.sh
./languages/languages.sh
./tools/tools.sh
./tools/vim.sh
./misc/misc.sh
./misc/qlplugins.sh

./cleanup.sh
