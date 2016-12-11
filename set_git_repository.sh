#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_git_repository() {

    declare -r GIT_ORIGIN="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ -z "$GIT_ORIGIN" ]; then
        print_error "Please provide a URL for the Git origin"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Run the following Git commands in the root of
    # the dotfiles directory, not in the `os/` directory.

    cd ../../ \
        || print_error "Failed to 'cd ../../'"

    execute \
        "git init && git remote add origin $GIT_ORIGIN" \
        "Initialize the Git repository"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if ! is_git_repository; then

        print_title "Set Git repository"
        initialize_git_repository "$1"

    fi

}

main "$1"
