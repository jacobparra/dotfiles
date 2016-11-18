#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install Python
    brew install python
    brew install python3


    echo "------------------------------"
    echo "Setting up virtual environments."

    # Install virtual environments globally
    # It fails to install virtualenv if PIP_REQUIRE_VIRTUALENV was true
    export PIP_REQUIRE_VIRTUALENV=false
    pip install virtualenv
    pip install virtualenvwrapper

    echo "------------------------------"
    echo "Source virtualenvwrapper from ~/.extra"

    EXTRA_PATH=~/.extra
    echo $EXTRA_PATH
    echo "" >> $EXTRA_PATH
    echo "" >> $EXTRA_PATH
    echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
    echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
    echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH
    echo "" >> $BASH_PROFILE_PATH
    source $EXTRA_PATH

    
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Python\n\n"

    install_apps
    printf "\n"

}

main
