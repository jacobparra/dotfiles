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
else
    # Not wrapped in `execute`: the login is interactive.
    gh auth login --hostname github.com --git-protocol ssh --web
    print_result $? "GitHub" || exit 1
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# The setup snippet clones this repo over HTTPS, since there is no key
# yet. Switch it to SSH so it can be pushed, but only when gh is logged in
# as the repo's owner: on a machine with another account (work), the
# HTTPS clone stays read-only on purpose.

declare -r REMOTE="$(git remote get-url origin 2> /dev/null)"

if [[ "$REMOTE" =~ ^https://github\.com/([^/]+)/([^/]+)$ ]]; then
    owner="${BASH_REMATCH[1]}"
    repo="${BASH_REMATCH[2]%.git}"

    if [ "$(gh api user --jq .login 2> /dev/null)" == "$owner" ]; then
        execute \
            "git remote set-url origin git@github.com:$owner/$repo.git" \
            "dotfiles remote → git@github.com:$owner/$repo.git"
    else
        print_success "dotfiles remote stays on HTTPS (read-only here)"
    fi
fi
