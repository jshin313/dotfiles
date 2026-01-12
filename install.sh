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

python3 -m pip install --upgrade pynvim

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
