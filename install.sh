sudo apt-get update
sudo apt-get upgrade -y
# sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update

sudo apt-get install curl
sudo apt-get install stow -y
sudo apt-get install vim -y

sudo apt-get install neovim -y
sudo apt-get install xdg-utils -y
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo apt-get install yarn -y
sudo apt-get install ripgrep -y
sudo apt-get install elfutils -y
sudo apt-get install python3-pip -y
sudo apt-get install zsh -y
sudo npm install -g neovim

stow gdb
stow tmux
stow vim
stow latexmk

# Set up vim directories
mkdir -p ~/.vim/undodir
mkdir -p ~/.vim/backupdir

# Install Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Make nvim's config the same as regular vim
mkdir -p ~/.config/nvim/
printf "set runtimepath^=~/.vim runtimepath+=~/.vim/after \nlet &packpath = &runtimepath \nsource ~/.vimrc\n" > ~/.config/nvim/init.vim

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

# Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# CoC
# sudo apt-get install clangd -y
# nvim +CocInstall coc-clangd +qall
# pip3 install jedi
# pip3 install pylint
# nvim +CocInstall coc-python +qall
# nvim +CocInstall coc-pairs +qall

# Markdown
mkdir -p ~/.local/lib/github-markdown-css/
curl -fLo ~/.local/lib/github-markdown-css/github-markdown.css --create-dirs https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css

# GDB
## Pwndbg
git clone https://github.com/pwndbg/pwndbg ~/.pwndbg
cd ~/.pwndbg
chmod +x setup.sh
./setup.sh
