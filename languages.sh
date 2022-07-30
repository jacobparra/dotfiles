#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh" \

declare -a LANGUAGES_TO_INSTALL=(
    'nodejs::NodeJS'
    'python::Python'
    'ruby::Ruby'
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

    print_subtitle "$language_label"

    asdf plugin-add $language_key &> /dev/null

    if asdf plugin-add $language_key &> /dev/null; then
        execute \
            "asdf plugin-add $language_key" \
            "Add $language_label plugin"
    else
        print_success "Add $language_label plugin"
    fi

    execute \
        "asdf install $language_key latest" \
        "Install latest $language_label"

    execute \
        "asdf global $language_key latest" \
        "Set latest $language_label as global"

done
