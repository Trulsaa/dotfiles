#!/bin/sh

# !!!. RUN THIS SCRIPT FROM WITHIN THE REPO FOLDER. (because of the symlinking)
if [ ! -f setup.sh ]; then
  echo "Run the script from within the dotfiles repo!!!"
  exit 1
fi

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Have brew install many things
brew install \
    git \
    git-lfs \
    hub \
    # fzf needs fd
    fd \
    zaquestion/tap/lab \
    wget \
    tmux \
    node \
    neovim \
    tree \
    reattach-to-user-namespace \
    the_silver_searcher \
    tldr

brew cask install \
    iterm2 \
    google-chrome \
    dropbox

# Implement support for python plugins in Nvim
pip3 install pynvim

# js importer
npm install -g import-js

npm i -g @elastic/javascript-typescript-langserver

# Install the powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# Download and install the Cobalt2 theme for zsh
git clone https://github.com/wesbos/Cobalt2-iterm.git
cp Cobalt2-iterm/cobalt2.zsh-theme ~/.oh-my-zsh/themes/
rm -rf Cobalt2-iterm

# Symlink dotfiles
ln -sf "$PWD"/gitconfig ~/.gitconfig
mkdir ~/.config
mkdir ~/.config/nvim
ln -sf "$PWD"/nvim/UltiSnips ~/.config/nvim/UltiSnips
ln -sf "$PWD"/nvim/after/ftplugin ~/.config/nvim/after/ftplugin
ln -sf "$PWD"/nvim/init.vim ~/.config/nvim/init.vim
ln -sf "$PWD"/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf "$PWD"/oh-my-zsh.sh ~/.oh-my-zsh.sh
ln -sf "$PWD"/tmux.conf ~/.tmux.conf

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp "$PWD"/cobalt2.zsh-theme ~/.oh-my-zsh/themes
ln -sf "$PWD"/zshrc ~/.zshrc
