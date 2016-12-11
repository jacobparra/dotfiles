#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # Newer version of utilities that come with macOS

    brew_install "git" "git"
    brew_install "less" "less" "homebrew/dupes"
    brew_install "openssh" "openssh" "homebrew/dupes"
    brew_install "rsync" "rsync" "homebrew/dupes"
    brew_install "sqlite" "sqlite"
    brew_install "svn" "svn"
    brew_install "vim" "vim --with-override-system-vi"
    brew_install "zsh" "zsh"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_subtitle "Outdated utils"

    install_apps

}

main
