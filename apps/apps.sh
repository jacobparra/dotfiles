#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./update.sh

./core/core.sh
./fonts/fonts.sh
./languages/languages.sh
./misc/misc.sh
./tools/tools.sh

./cleanup.sh
