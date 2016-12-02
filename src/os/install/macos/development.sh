#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # GNU core utilities (those that come with OS X are outdated)
    brew_install "findutils" "findutils --default-names"
    brew_install "gnu-sed" "gnu-sed --default-names"
    brew_install "gnu-tar" "gnu-tar --default-names"
    brew_install "gnu-which" "gnu-which --default-names"
    brew_install "gnutls" "gnutls --default-names"
    brew_install "grep" "grep --default-names"
    brew_install "coreutils" "coreutils"
    brew_install "binutils" "binutils"
    brew_install "diffutils" "diffutils"
    brew_install "gpg" "gpg"
    brew_install "gzip" "gzip"
    brew_install "htop" "htop"
    brew_install "watch" "watch"
    brew_install "wget" "wget"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Newer version of utilities that come with OS x
    brew_install "Git" "git"
    brew_install "less" "less"
    brew_install "openssh" "openssh"
    brew_install "rsync" "rsync"
    brew_install "Tmux" "tmux"
    brew_install "Tmux (pasteboard)" "reattach-to-user-namespace"
    brew_install "unzip" "unzip"
    brew_install "Vim" "vim --with-override-system-vi"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Languages
    brew_install "Java" "java" "caskroom/cask" "cask"
    brew_install python
    brew_install python3
    # brew_install ruby-build
    # brew_install rbenv

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Development tool casks
    brew_install "Atom" "atom" "caskroom/cask" "cask"
    brew_install "Arduino" "arduino" "caskroom/cask" "cask"
    brew_install "Docker" "docker" "caskroom/cask" "cask"
    brew_install "ImageMagick" "imagemagick --with-webp"
    brew_install "Iterm2" "iterm2" "caskroom/cask" "cask"
    brew_install "Postman" "postman" "caskroom/cask" "cask"
    brew_install "ShellCheck" "shellcheck"

    # echo "------------------------------"
    # echo "Setting up virtual environments."
    #
    # # Install virtual environments globally
    # # It fails to install virtualenv if PIP_REQUIRE_VIRTUALENV was true
    # export PIP_REQUIRE_VIRTUALENV=false
    # pip install virtualenv
    # pip install virtualenvwrapper

    # EXTRA_PATH=~/.extra
    # echo $EXTRA_PATH
    # echo "" >> $EXTRA_PATH
    # echo "" >> $EXTRA_PATH
    # echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
    # echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
    # echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH
    # echo "" >> $BASH_PROFILE_PATH
    # source $EXTRA_PATH


    # # Install ruby-build and rbenv
    # LINE='eval "$(rbenv init -)"'
    # grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Development tools\n\n"

    install_apps
    printf "\n"

}

main
