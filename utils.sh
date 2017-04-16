#!/bin/bash

# mkd() {
#     if [ -n "$1" ]; then
#         if [ -e "$1" ]; then
#             if [ ! -d "$1" ]; then
#                 print_error "$1 - a file with the same name already exists!"
#             else
#                 print_success "$1"
#             fi
#         else
#             execute "mkdir -p $1" "$1"
#         fi
#     fi
# }

print_title() {
    _print_in_purple "\n • $1\n"
}

print_subtitle() {
    _print_in_purple "\n   $1\n\n"
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

ask_for_sudo() {

    # Ask for the administrator password upfront.

    sudo -v &> /dev/null

    # Update existing `sudo` time stamp
    # until this script has finished.
    #
    # https://gist.github.com/cowboy/3118588

    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &> /dev/null &

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

create_symlink() {

    local sourceFile="$1"
    local targetFile=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    targetFile="$HOME/.$(printf "%s" "$(basename $sourceFile)" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ] || $skipQuestions; then

        execute \
            "ln -fs $sourceFile $targetFile" \
            "$targetFile → $sourceFile"

    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
        print_success "$targetFile → $sourceFile"
    else

        if ! $skipQuestions; then

            ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
            if answer_is_yes; then

                rm -rf "$targetFile"

                execute \
                    "ln -fs $sourceFile $targetFile" \
                    "$targetFile → $sourceFile"

            else
                print_error "$targetFile → $sourceFile"
            fi

        fi

    fi

}

# append_to_local_shell_config_file() {
#
#     declare -r FILE_PATHFILE_PATH="$HOME/.bash.local"
#
#     # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
#     if [ ! -e "$FILE_PATH" ] || [ -z "$FILE_PATH" ]; then
#         printf "%s\n\n" "#!/bin/bash" >> "$FILE_PATH"
#         print_result $? "Create $FILE_PATH"
#     fi
#
#     # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
#     if ! grep "$1" < "$FILE_PATH" &> /dev/null; then
#         execute \
#             "printf '%s' '$configs' >> $FILE_PATH \
#                 && . $FILE_PATH" \
#             "$2 (update $FILE_PATH)"
#     fi
# }

cmd_exists() {
    command -v "$1" &> /dev/null
}

skip_questions() {

    while [ $# -gt 0 ]; do
        case $1 in
            -y|--yes) return 0;;
        esac
        shift 1
    done

    return 1

}

get_os() {

    local os=""
    local kernelName=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    kernelName="$(uname -s)"

    if [ "$kernelName" == "Darwin" ]; then
        os="macos"
    elif [ "$kernelName" == "Linux" ] && [ -e "/etc/lsb-release" ]; then
        os="ubuntu"
    else
        os="$kernelName"
    fi

    printf "%s" "$os"

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
