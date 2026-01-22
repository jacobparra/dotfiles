#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh" \

declare -a LANGUAGES_TO_INSTALL=(
    'nodejs::Node.js'
    'python::Python'
)

###################################################################

print_title "Setup languages"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "ASDF" "asdf"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare language=""
declare language_key=""
declare language_label=""

for language in "${LANGUAGES_TO_INSTALL[@]}"; do

    language_key="${language%%::*}"
    language_label="${language##*::}"

    print_subtitle "$language_key"

    if asdf plugin add "$language_key" &> /dev/null; then
        print_success "Add $language_label plugin"
    else
        print_success "Add $language_label plugin (already installed)"
    fi

    execute \
        "asdf install $language_key latest" \
        "Install latest $language_label"

    execute \
        "asdf set --home $language_key latest" \
        "Set latest $language_label as default"

done
