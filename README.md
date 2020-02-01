# [Jacob](https://github.com/jacobparra)’s dotfiles

These are the base dotfiles that I start with when I set up a
new environment.

## Setup

To set up the `dotfiles` just run the following snippet in the
terminal:

(:warning: **DO NOT** run the `setup` snippet if you don't fully
understand [what it does](setup.sh). Seriously, **DON'T**!)

`git clone https://github.com/jacobparra/dotfiles ~/Code/dotfiles && ~/Code/dotfiles/setup.sh`

That's it! :sparkles:

The setup process will:

* Clone the dotfiles on your computer.
* Setup [SSH keys](ssh_keys.sh) for github.
* Setup [Zsh shell](shell.sh) with [Oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) and [Powerlevel10k](https://github.com/romkatv/powerlevel10k).
* Install [languages](languages.sh) for web development (`NodeJS`, `Python` and `Ruby`).
* Install [applications / command-line tools](apps.sh) for macOS.
* Set custom macOS [preferences](preferences.sh).

### Forks

If you decide to fork this project, don't forget to substitute my
username with your own in the [`setup` snippet](#setup).


## Update

To update the dotfiles you can either run the [`setup`
script](setup.sh) or, if you want to just update one particular
part, run the appropriate script.


## Acknowledgements

Inspiration and code was taken from many sources, including:

* [Cătălin Mariș](https://github.com/alrra)
  [dotfiles](https://github.com/alrra/dotfiles)
* [Mathias Bynens'](https://github.com/mathiasbynens)
  [dotfiles](https://github.com/mathiasbynens/dotfiles)


## License

The code is available under the [MIT license](LICENSE.txt).
