#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "Setup shell"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "Zsh" "zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Oh-my-zsh

if [ -d "$HOME/.oh-my-zsh" ]; then
    print_success "Oh-my-zsh"
else
    execute \
    "export RUNZSH=no && \
        $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    "Oh-my-zsh"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Powerlevel10k

if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    print_success "Powerlevel10k ZSH theme"
else
    execute \
        "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k" \
        "Powerlevel10k ZSH theme"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install zsh-syntax-highlighting

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    print_success "zsh-syntax-highlighting"
else
    execute \
        "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" \
        "zsh-syntax-highlighting"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install zsh-autosuggestions

if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    print_success "zsh-autosuggestions"
else
    execute \
        "git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" \
        "zsh-autosuggestions"
fi

brew_install "Font Nerd Fonts" "font-hack-nerd-font" "homebrew/cask-fonts"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Create symbolic links"

declare -x DOTFILES_FOLDER="$(pwd)/dotfiles"

declare -a FILES_TO_SYMLINK=(
    "gitattributes"
    "gitconfig"
    "gitignore"
    "ssh/config"
    "zshrc"
    "p10k.zsh"
)

declare i=""
declare sourceFile=""
declare targetFile=""

for i in "${FILES_TO_SYMLINK[@]}"; do

    sourceFile="$DOTFILES_FOLDER/$i"
    targetFile="$HOME/.$i"

    if [ ! -e "$targetFile" ]; then

        execute \
            "ln -fs $sourceFile $targetFile" \
            "$targetFile → $sourceFile"

    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then

        print_success "$targetFile → $sourceFile"

    else

        rm -rf "$targetFile"

        execute \
            "ln -fs $sourceFile $targetFile" \
            "$targetFile → $sourceFile"

    fi

done
