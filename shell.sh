#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "Setup shell"

declare -x DOTFILES_FOLDER="$(pwd)/dotfiles"

# Point $2 at $1, replacing whatever is there unless it already does.
link() {
    local -r sourceFile="$1"
    local -r targetFile="$2"

    mkdir -p "$(dirname "$targetFile")"

    if [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
        print_success "$targetFile → $sourceFile"
    else
        rm -rf "$targetFile"
        execute \
            "ln -fs $sourceFile $targetFile" \
            "$targetFile → $sourceFile"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Create symbolic links"

# A fresh Mac has no ~/.ssh yet, and ssh refuses a group-readable one.
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"

declare -a FILES_TO_SYMLINK=(
    "gitattributes"
    "gitconfig"
    "gitignore"
    "ssh/config"
    "zshrc"
)

for i in "${FILES_TO_SYMLINK[@]}"; do
    link "$DOTFILES_FOLDER/$i" "$HOME/.$i"
done

# Ghostty and Starship read from XDG rather than from a dotfile in $HOME.
link "$DOTFILES_FOLDER/ghostty/config" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
link "$DOTFILES_FOLDER/starship.toml" "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"

# Personal scripts in bin/ are linked into ~/.local/bin, which zshrc puts
# on the PATH.
for sourceFile in "$(pwd)"/bin/*; do
    link "$sourceFile" "$HOME/.local/bin/$(basename "$sourceFile")"
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Create local config files"

declare -a LOCAL_EXAMPLES=(
    "ssh/config.local.example"
    "zshrc.local.example"
)

declare -a LOCAL_TARGETS=(
    "$HOME/.ssh/config.local"
    "$HOME/.zshrc.local"
)

for idx in "${!LOCAL_EXAMPLES[@]}"; do
    sourceFile="$DOTFILES_FOLDER/${LOCAL_EXAMPLES[$idx]}"
    targetFile="${LOCAL_TARGETS[$idx]}"

    if [ -e "$targetFile" ]; then
        print_success "$targetFile (already exists)"
    else
        execute \
            "cp $sourceFile $targetFile" \
            "$targetFile (created from example)"
    fi
done

# The commit email is the one setting that differs per machine, so it is
# asked for instead of copied: gitconfig sets useConfigOnly, and without
# this file git refuses to commit rather than guessing an identity.
targetFile="$HOME/.gitconfig.local"

if [ -e "$targetFile" ]; then
    print_success "$targetFile (already exists)"
else
    ask "Email for git commits on this machine: "
    printf "[user]\n    email = %s\n" "$(get_answer)" > "$targetFile"
    print_result $? "$targetFile (created)"
fi
