#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # GNU core utilities (those that come with OS X are outdated)

    brew_install "binutils" "binutils"
    brew_install "coreutils" "coreutils"
    brew_install "diffutils" "diffutils" "homebrew/dupes"
    brew_install "ed" "ed --with-default-names"
    brew_install "emacs" "emacs"
    brew_install "findutils" "findutils --with-default-names"
    brew_install "gawk" "gawk"
    brew_install "gnu-indent" "gnu-indent --with-default-names"
    brew_install "gnu-sed" "gnu-sed --with-default-names"
    brew_install "gnu-tar" "gnu-tar --with-default-names"
    brew_install "gnu-which" "gnu-which --with-default-names"
    brew_install "gnutls" "gnutls --with-default-names"
    brew_install "grep" "grep --with-default-names" "homebrew/dupes"
    brew_install "gzip" "gzip" "homebrew/dupes"
    brew_install "make" "make"
    brew_install "nano" "nano"
    brew_install "screen" "screen" "homebrew/dupes"
    brew_install "watch" "watch"
    brew_install "wdiff" "wdiff --with-gettext"
    brew_install "wget" "wget"

}

add_path_configs() {

    declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.bash.local"

    declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# GNU utilities

PATH=\"/usr/local/opt/gnu-coreutils/libexec/gnubin:\$PATH\"
MANPATH=\"/usr/local/opt/coreutils/libexec/gnuman:\$MANPATH\"
MANPATH=\"/usr/local/opt/gnu-tar/libexec/gnuman:\$MANPATH\"
"
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If needed, add the necessary configs in the
    # local shell configuration file.

    if ! grep "gnubin" < "$LOCAL_SHELL_CONFIG_FILE" &> /dev/null; then
        execute \
            "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE \
                && . $LOCAL_SHELL_CONFIG_FILE" \
            "GNU utils (update $LOCAL_SHELL_CONFIG_FILE)"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_subtitle "GNU utils"

    install_apps \
        && add_path_configs

}

main
