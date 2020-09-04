sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install stow -y
stow gdb
stow git
stow tmux
stow vim
rm ~/.bashrc
stow bash
stow latexmk

sudo apt-get install vim -y

# Set up vim directories
mkdir -p ~/.vim/undodir
mkdir -p ~/.vim/backupdir

# Install Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo apt-get install neovim -y
sudo apt-get install xdg-utils -y
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo apt-get install yarn -y
sudo apt-get install ripgrep -y
sudo apt-get install elfutils -y
sudo apt-get install python3-pip -y

# Make nvim's config the same as regular vim
mkdir -p ~/.config/nvim/
echo -e "set runtimepath^=~/.vim runtimepath+=~/.vim/after \n \
     let &packpath = &runtimepath \n \
     source ~/.vimrc" > ~/.config/nvim/init.vim

sudo npm install -g neovim

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

# CoC
sudo apt-get install clangd -y
nvim +CocInstall coc-clangd +qall
pip3 install jedi
pip3 install pylint
nvim +CocInstall coc-python +qall

# Markdown
mkdir -p ~/.local/lib/github-markdown-css/
curl -fLo ~/.local/lib/github-markdown-css/github-markdown.css --create-dirs https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css

