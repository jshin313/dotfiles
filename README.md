# dotfiles

## Installation
```console
$ sudo apt install git -y
$ git clone https://github.com/jshin313/dotfiles ~/.dotfiles
$ cd .dotfiles
$ ./install.sh
```

## How to VIM
Check out [The Primeagen](https://www.youtube.com/channel/UC8ENHE5xdFSwx71u3fDH5Xw)

## VIM Plugins
`:PlugUpdate`: Update Plugins
`:PlugClean`: Remove unneeded plugins
`:PlugInstall`: Add plugins

## Tmux Plugins
`<Prefix>I`: Install tmux plugins
`<Prefix>U`: Update tmux plugins

## Terminal Colorscheme
https://github.com/Gogh-Co/Gogh

## Zsh
```console
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Run the above to install Oh My Zsh

Then make sure to update the following in `~/.zshrc` for vim support
```
plugins=(
	vi-mode
	git
)
```

## Windows
* Use this guide to install i3: https://misterderpie.com/posts/ubuntu-wsl2-i3/
* To set gruvbox
	* Run the xfce terminal command found in `install.sh`
	* Install the gtk gruvbox colors also found in `install.sh`

## LaTeX
* Two nice resources to check out for using vim with LaTeX
	* https://www.ejmastnak.com/tutorials/vim-latex/intro.html
	* https://castel.dev/post/lecture-notes-1/
* I like to comment out these UtilSnips since they get in the way for me
	* Figures
	* Tables
* Vim configurations for tex and markdown are in vim/.vim/ftplugin


