#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_virtualenvwrapper_configs() {

    declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.bash.local"

    declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Python 2.7 Virtual Environments

export PIP_REQUIRE_VIRTUALENV=truw

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
source /usr/local/bin/virtualenvwrapper.sh
"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! grep "virtualenvwrapper" < "$LOCAL_SHELL_CONFIG_FILE" &> /dev/null; then
        execute \
            "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE \
                && . $LOCAL_SHELL_CONFIG_FILE" \
            "virtualenvwrapper (update $LOCAL_SHELL_CONFIG_FILE)"
    fi
}

update_pip() {

    execute \
        "pip install --upgrade pip setuptools" \
        "Update pip"

}

install_pip_package() {

    execute \
        "pip install $2" \
        "$1"

}

install_python() {

    brew_install "Python 2.7" "python" \
        && update_pip \
        && install_pip_package "Virtualenv" "virtualenv" \
        && install_pip_package "Virtualenv Wrapper" "virtualenvwrapper" \
        && add_virtualenvwrapper_configs

}

update_pip3() {

    execute \
        "pip3 install --upgrade pip setuptools wheel" \
        "Update pip3"

}

install_python3() {

    brew_install "Python 3" "python3" \
        && update_pip3

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_subtitle "Python"

    install_python
    install_python3

}

main
