# [Jacob](https://github.com/jacobparra)’s dotfiles

These are the base dotfiles that I start with when I set up a
new environment.

## Setup

To set up the `dotfiles` just run the following snippet in the
terminal:

(:warning: **DO NOT** run the `setup` snippet if you don't fully
understand [what it does](setup.sh). Seriously, **DON'T**!)

```bash
git clone https://github.com/jacobparra/dotfiles ~/Code/dotfiles && ~/Code/dotfiles/setup.sh personal
```

Use `work` instead of `personal` on the work machine; without either,
the setup asks. On a fresh Mac the first `git` prompts to install the
Xcode Command Line Tools: accept, then run the line again.

The setup process will:

* Install [Homebrew](homebrew.sh) and the Xcode Command Line Tools.
* Install [packages](packages.sh): everything in [`Brewfile`](Brewfile)
  plus [`Brewfile.personal`](Brewfile.personal) or
  [`Brewfile.work`](Brewfile.work).
* Set up the [shell](shell.sh): zsh with [Starship](https://starship.rs),
  symlinks for the files in [`dotfiles/`](dotfiles), and the per-machine
  `~/.zshrc.local`, `~/.ssh/config.local` and `~/.gitconfig.local`
  (it asks for the commit email).
* Install [tools](tools.sh): Node.js through `fnm`, and Claude Code.
* Log in to [GitHub](github.sh) with `gh`, which creates and uploads the
  SSH key.

On the work machine, log in to GitLab by hand afterwards:
`glab auth login --hostname <gitlab host>`.

## Update

To update the dotfiles you can either run the [`setup`
script](setup.sh) or, if you want to just update one particular
part, run the appropriate script.

To see what is installed but missing from the Brewfiles:

```bash
cat Brewfile Brewfile.personal | brew bundle cleanup --file=-
```


## Acknowledgements

Inspiration and code was taken from many sources, including:

* [Cătălin Mariș](https://github.com/alrra)
  [dotfiles](https://github.com/alrra/dotfiles)
* [Mathias Bynens'](https://github.com/mathiasbynens)
  [dotfiles](https://github.com/mathiasbynens/dotfiles)


## License

The code is available under the [MIT license](LICENSE.txt).
