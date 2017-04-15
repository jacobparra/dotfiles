#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_github_ssh_key() {

    local sshKeyFileName="$HOME/.ssh/github"
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ssh -T git@github.com &> /dev/null

    if [ $? -eq 1 ]; then
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If there is already a file with that name remove it

    if [ -f "$sshKeyFileName" ]; then
        rm $sshKeyFileName
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Generate SSH keys

    ask "Please provide an email address: " && printf "\n"
    ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$sshKeyFileName"

    print_result $? "Generate SSH keys"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add SSH configs

    printf "%s\n" \
        "Host github.com" \
        "  IdentityFile $sshKeyFileName" \
        "  LogLevel ERROR" >> ~/.ssh/config

    print_result $? "Add SSH configs"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Copy public ssh key to clipboard

    if cmd_exists "pbcopy"; then
        pbcopy < "${sshKeyFileName}.pub"
        print_result $? "Copy public SSH key to clipboard"

    elif cmd_exists "xclip"; then
        xclip -selection clip < "${sshKeyFileName}.pub"
        print_result $? "Copy public SSH key to clipboard"

    else
        cat ${sshKeyFileName}.pub
        print_warning "Please copy the public SSH key to clipboard"
    fi
    
    rm "${sshKeyFileName}.pub"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Open github ssh page

    declare -r GITHUB_SSH_URL="https://github.com/settings/ssh"

    local os="$(get_os)"

    if [ "$os" == "ubuntu" ]; then
        ask "Please add the public SSH key to GitHub ($GITHUB_SSH_URL)"
    elif cmd_exists "open"; then
        open "$GITHUB_SSH_URL"
    else
        print_warning "Please add the public SSH key to GitHub ($GITHUB_SSH_URL)"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Test ssh connection

    while true; do
        ssh -T git@github.com &> /dev/null
        if [ $? -eq 1 ]; then
            print_success "Set up GitHub SSH keys"
            break
        fi
        sleep 5
    done

}

set_git_repository() {

    declare -r GIT_ORIGIN="$1"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! ([ -d .git ] || git rev-parse --git-dir > /dev/null); then
        execute "git init" "Initialize the Git repository"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ -z "$GIT_ORIGIN" ]; then
        print_error "Please provide a URL for the Git origin"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$(git config --get remote.origin.url)" != "$GIT_ORIGIN" ]; then
        execute "git remote add origin $GIT_ORIGIN" "Add remote origin"
    fi

}

update_git_repository () {

    local skipQuestions=false

    skip_questions "$@" \
        && skipQuestions=true

    if ! $skipQuestions; then
        ask_for_confirmation "Do you want to update the content from the 'dotfiles' directory?"
        if ! answer_is_yes; then
            return 0
        fi
    fi
    
    git fetch --all 1> /dev/null \
        && git reset --hard origin/master 1> /dev/null \
        && git clean -fd 1> /dev/null

    print_result $? "Update content"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_title "Update Git repository"

    set_github_ssh_key
    set_git_repository "$1"
    update_git_repository "$@"

}

main "$@"
