#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

###################################################################

print_title "Setup GitHub"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# gh logs in through the browser and, with the SSH protocol, offers to
# generate a key and upload it to the account. Git then pushes over SSH
# with that key, and gh keeps its token for the API only (PRs, issues).
# Log in with the account this machine belongs to.

if gh auth status &> /dev/null; then
    print_success "GitHub ($(gh api user --jq .login 2> /dev/null))"
    exit 0
fi

# Not wrapped in `execute`: the login is interactive.
gh auth login --hostname github.com --git-protocol ssh --web

print_result $? "GitHub"
