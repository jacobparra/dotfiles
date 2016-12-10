#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # GNU core utilities (those that come with OS X are outdated)
    print_in_purple "   GNU utils\n"

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

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Newer version of utilities that come with macOS
    print_in_purple "   Outdated utils\n"

    brew_install "git" "git"
    brew_install "less" "less" "homebrew/dupes"
    brew_install "openssh" "openssh" "homebrew/dupes"
    brew_install "rsync" "rsync" "homebrew/dupes"
    brew_install "sqlite" "sqlite"
    brew_install "svn" "svn"
    brew_install "vim" "vim --with-override-system-vi"
    brew_install "zsh" "zsh"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Other utilities
    print_in_purple "   More utils\n"

    brew_install "GPG" "gpg"
    brew_install "GPG Agent" "gpg-agent"
    brew_install "htop" "htop --with-ncurses"
    brew_install "ImageMagick" "imagemagick --with-webp"
    brew_install "Java" "java" "caskroom/cask" "cask"
    brew_install "shellcheck" "shellcheck"
    brew_install "tmux" "tmux"
    brew_install "tmux (pasteboard)" "reattach-to-user-namespace"

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

    if ! grep "libexec" < "$LOCAL_SHELL_CONFIG_FILE" &> /dev/null; then
        execute \
            "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE \
                && . $LOCAL_SHELL_CONFIG_FILE" \
            "GNU utilities (update $LOCAL_SHELL_CONFIG_FILE)"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Core utilities\n\n"

    # install_apps
        # &&
        add_path_configs
    printf "\n"

}

main
