#!/bin/zsh
if [[ "$UNAME" == "linux" ]]; then
	if [[ "$(awk -F= '/^NAME/{print $2}' /etc/os-release)" == "Ubuntu" ]]; then
		echo "Detected $UNAME $(/etc/os-release)"
		sudo apt-get update
		sudo apt-get upgrade -y
		sudo apt update

		sudo apt-get install curl
		sudo apt-get install stow -y
		sudo apt-get install vim -y

		# sudo apt-get install neovim -y
		sudo apt-get install xdg-utils -y
		sudo apt-get install nodejs -y
		sudo apt-get install npm -y
		sudo apt-get install yarn -y
		sudo apt-get install ripgrep -y
		sudo apt-get install elfutils -y
		sudo apt-get install python3-pip -y
		sudo apt-get install zsh -y
		npm list neovim -g || sudo npm install -g neovim
		# sudo apt install i3 -y
		sudo apt install texlive-full texlive-latex-recommended -y
		sudo apt install xdotool -y # needed for zathura for latex viewing

		# install neovim
		# wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
		wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
		sudo tar xvf nvim-linux-x86_64.tar.gz -C /opt
		rm -rf *.tar.gz
		echo "export PATH=$PATH:/opt/nvim-linux-x86_64/bin" >> ~/.zshrc

	elif [[ "$MACH_NAME" == "NERSC perlmutter" ]]; then
		if [[ -n "$COMMON" ]]; then
			echo "Detected $MACH_NAME"
			wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
			tar xvf nvim-linux-x86_64.tar.gz 
			mv nvim-linux-x86_64/bin/* $HOME/.local/bin/
			mv nvim-linux-x86_64/share/* $HOME/.local/share/
			mv nvim-linux-x86_64/lib/* $HOME/.local/lib/
			rm -rf *.tar.gz

			wget https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz -O ripgrep.tar.gz
			tar xvf ripgrep.tar.gz
			mv ripgrep-15.1.0-x86_64-unknown-linux-musl/rg $HOME/.local/bin

			wget https://ftp.gnu.org/gnu/stow/stow-2.4.1.tar.gz
			tar xvf stow-2.4.1.tar.gz
			cd stow-2.4.1
			./configure --prefix=$HOME/.local && make
			make install 
			cd ..
		
			rm *tar.gz


		else
			echo "Environment variable COMMON not set. Please set it to with export COMMON=/global/common/software/<accountid>/<username>/"
			exit 1
		fi
	else
		echo "Unknown OS. Aborting."
		exit 1
	fi
fi

# install oh my zsh
wget -O zsh_install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh zsh_install.sh
rm zsh_install.sh

rm -rf ~/.zshrc

stow zsh
stow gdb
stow tmux
stow vim
stow latexmk
# stow zathura

source ~/.zshrc

# Set up vim directories
mkdir -p ~/.vim/undodir
mkdir -p ~/.vim/backupdir

# Install Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Make nvim's config the same as regular vim
mkdir -p ~/.config/nvim/
printf "set runtimepath^=~/.vim runtimepath+=~/.vim/after \nlet &packpath = &runtimepath \nsource ~/.vimrc\n" > ~/.config/nvim/init.vim

curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install --upgrade pynvim

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

# Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Markdown
mkdir -p ~/.local/lib/github-markdown-css/
curl -fLo ~/.local/lib/github-markdown-css/github-markdown.css --create-dirs https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css

# GDB
## Pwndbg
git clone https://github.com/pwndbg/pwndbg ~/.pwndbg
cd ~/.pwndbg
chmod +x setup.sh
./setup.sh


# Below for xfce4 Terminal
# sudo apt install gtk2-engines-murrine
# git clone https://github.com/morhetz/gruvbox-contrib
# mkdir -p ~/.local/share/xfce4/terminal/colorschemes
# cp gruvbox-contrib/xfce4-terminal/*.theme ~/.local/share/xfce4/terminal/colorschemes/
# rm -rf gruvbox-contrib
# git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk
# mkdir -p ~/.local/share/themes/
# mkdir -p ~/.local/share/icons/
# mv gruvbox-material-gtk/themes/* ~/.local/share/themes/
# mv gruvbox-material-gtk/icons/* ~/.local/share/icons/
# rm -rf gruvbox-material-gtk
