#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "../utils_macos.sh"

declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.bash.local"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_rbenv_configs() {

    declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ruby rbenv and binstubs

eval \"\$(rbenv init -)\"

PATH="./bin:$PATH"

export PATH
"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! grep "rbenv" < "$LOCAL_SHELL_CONFIG_FILE" &> /dev/null; then
        execute \
            "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE \
                && . $LOCAL_SHELL_CONFIG_FILE" \
            "rbenv (update $LOCAL_SHELL_CONFIG_FILE)"
    fi
}

install_latest_stable_ruby() {

    declare -r LATEST_STABLE=$(rbenv install -l | grep -v - | tail -1)

    if ! rbenv versions | grep -q $(echo $LATEST_STABLE); then
        execute \
            ". $LOCAL_SHELL_CONFIG_FILE \
                && rbenv install $LATEST_STABLE \
                && rbenv global $LATEST_STABLE" \
            "rbenv (install latest Ruby)"
    fi

}

install_gem() {

  execute \
      ". $LOCAL_SHELL_CONFIG_FILE \
          && gem install $2" \
      "$1"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_subtitle "Ruby"

    brew_install "rbenv" "rbenv" \
        && brew_install "ruby-build" "ruby-build" \
        && add_rbenv_configs \
        && install_latest_stable_ruby \
        && install_gem "Bundler" "bundler"

}

main
