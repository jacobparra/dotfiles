# Packages for every machine. packages.sh installs this file plus the
# role-specific one (Brewfile.personal or Brewfile.work).
#
# To spot drift between this list and what is actually installed:
#   cat Brewfile Brewfile.<role> | brew bundle cleanup --file=-

# Shell
brew "starship"
brew "fzf"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

# Development
brew "gh"
brew "fnm"
brew "uv"

cask "font-jetbrains-mono-nerd-font"
cask "ghostty"
cask "visual-studio-code"

# Productivity
cask "google-chrome"
cask "claude"
cask "eddmann/tap/claudemeter"
cask "logi-options+"
cask "monitorcontrol"

# Mac App Store: needs a signed-in App Store, which a managed Mac may not
# allow. brew bundle reports these as failed and carries on with the rest.
brew "mas"
mas "Magnet", id: 441258766
mas "Amphetamine", id: 937984704
mas "WhatsApp", id: 310633997

# Installed outside Homebrew:
#   - Claude Code CLI: tools.sh runs the native installer, which self-updates.
