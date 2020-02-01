#!/bin/bash

print_title() {
    _print_in_purple "\n • $1\n\n"
}

print_subtitle() {
    _print_in_purple "\n   $1\n"
}

print_question() {
    _print_in_yellow "   [?] $1"
}

print_result() {

    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"

}

print_success() {
    _print_in_green "   [✔] $1\n"
}

print_error() {
    _print_in_red "   [✖] $1 $2\n"
}

print_warning() {
    _print_in_yellow "   [!] $1\n"
}

answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

get_answer() {
    printf "%s" "$REPLY"
}

ask() {
    print_question "$1"
    read -r
}

ask_without_echo() {
    print_question "$1"
    read -s
}

ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -r -n 1
    printf "\n"
}

execute() {

    local -r CMDS="$1"
    local -r MSG="${2:-$1}"
    local -r TMP_FILE="$(mktemp /tmp/XXXXX)"

    local exitCode=0
    local cmdsPID=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If the current process is ended,
    # also end all its subprocesses.

    _set_trap "EXIT" "_kill_all_subprocesses"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Execute commands in background

    eval "$CMDS" \
        &> /dev/null \
        2> "$TMP_FILE" &

    cmdsPID=$!

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Show a spinner if the commands
    # require more time to complete.

    _show_spinner "$cmdsPID" "$CMDS" "$MSG"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait for the commands to no longer be executing
    # in the background, and then get their exit code.

    wait "$cmdsPID" &> /dev/null
    exitCode=$?

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Print output based on what happened.

    print_result $exitCode "$MSG"

    if [ $exitCode -ne 0 ]; then
        _print_error_stream < "$TMP_FILE"
    fi

    rm -rf "$TMP_FILE"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    return $exitCode

}

cmd_exists() {
    command -v "$1" &> /dev/null
}

brew_install() {

    declare -r CMD="$3"
    declare -r FORMULA="$2"
    declare -r FORMULA_READABLE_NAME="$1"
    declare -r TAP_VALUE="$4"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `Homebrew` is installed.

    if ! cmd_exists "brew"; then
        print_error "$FORMULA_READABLE_NAME ('Homebrew' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If `brew tap` needs to be executed,
    # check if it executed correctly.

    if [ -n "$TAP_VALUE" ]; then
        if ! brew tap "$TAP_VALUE" &> /dev/null; then
            print_error "$FORMULA_READABLE_NAME ('brew tap $TAP_VALUE' failed)"
            return 1
        fi
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified formula.

    if brew $CMD list "$FORMULA" &> /dev/null; then
        print_success "$FORMULA_READABLE_NAME"
    else
        execute \
            "brew $CMD install $FORMULA" \
            "$FORMULA_READABLE_NAME"
    fi

}

_print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

_print_in_green() {
    _print_in_color "$1" 2
}

_print_in_purple() {
    _print_in_color "$1" 5
}

_print_in_red() {
    _print_in_color "$1" 1
}

_print_in_yellow() {
    _print_in_color "$1" 3
}

_print_error_stream() {
    while read -r line; do
        print_error "↳ ERROR: $line"
    done
}

_set_trap() {

    trap -p "$1" | grep "$2" &> /dev/null \
        || trap '$2' "$1"

}

_kill_all_subprocesses() {

    local i=""

    for i in $(jobs -p); do
        kill "$i"
        wait "$i" &> /dev/null
    done

}

_show_spinner() {

    local -r FRAMES='/-\|'

    # shellcheck disable=SC2034
    local -r NUMBER_OR_FRAMES=${#FRAMES}

    local -r CMDS="$2"
    local -r MSG="$3"
    local -r PID="$1"

    local i=0
    local frameText=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Note: In order for the Travis CI site to display
    # things correctly, it needs special treatment, hence,
    # the "is Travis CI?" checks.

    if [ "$TRAVIS" != "true" ]; then

        # Provide more space so that the text hopefully
        # doesn't reach the bottom line of the terminal window.
        #
        # This is a workaround for escape sequences not tracking
        # the buffer position (accounting for scrolling).
        #
        # See also: https://unix.stackexchange.com/a/278888

        printf "\n\n\n"
        tput cuu 3

        tput sc

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Display spinner while the commands are being executed.

    while kill -0 "$PID" &>/dev/null; do

        frameText="   [${FRAMES:i++%NUMBER_OR_FRAMES:1}] $MSG"

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Print frame text.

        if [ "$TRAVIS" != "true" ]; then
            printf "%s\n" "$frameText"
        else
            printf "%s" "$frameText"
        fi

        sleep 0.2

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Clear frame text.

        if [ "$TRAVIS" != "true" ]; then
            tput rc
        else
            printf "\r"
        fi

    done

}
