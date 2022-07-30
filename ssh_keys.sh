#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

declare -r SSH_KEY_FILENAME="$HOME/.ssh/github"

###################################################################

print_title "Setup Github SSH keys"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ssh -T git@github.com -i $SSH_KEY_FILENAME &> /dev/null

if [ $? -eq 1 ]; then
    print_success "Successfully authenticated"
    exit 0
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ask "Please provide an email address: " && printf "\n"
ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$SSH_KEY_FILENAME"

print_result $? "Generate SSH keys"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if cmd_exists "pbcopy"; then
    pbcopy < "$SSH_KEY_FILENAME.pub"
    print_result $? "Copy public SSH key to clipboard"
else
    print_warning "Please copy the public SSH key ($SSH_KEY_FILENAME.pub) to clipboard"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r GITHUB_SSH_URL="https://github.com/settings/ssh"

if cmd_exists "open"; then
    open "$GITHUB_SSH_URL"
else
    print_warning "Please add the public SSH key to GitHub ($GITHUB_SSH_URL)"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

while true; do
    ssh -T git@github.com -i $SSH_KEY_FILENAME &> /dev/null
    [ $? -eq 1 ] && break
    sleep 5
done \
    && rm "${SSH_KEY_FILENAME}.pub"

print_result $? "Successfully authenticated"
