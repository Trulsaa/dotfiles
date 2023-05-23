#!/bin/sh

# Install Homebrew by using the link on the website brew.sh
# Then install git with homebrew - brew install git
# Clone this repo - git clone https://github.com/Trulsaa/dotfiles.git
# !!!. THEN RUN THIS SCRIPT FROM WITHIN THE REPO FOLDER. (because of the symlinking)

# Have brew install many things
brew install \
  git-lfs \
  fd \
  tmux \
  node \
  neovim \
  tree \
  reattach-to-user-namespace \
  ripgrep \
  alacritty

brew tap homebrew/cask-fonts
brew install --cask \
  font-fira-code-nerd-font

# Symlink dotfiles
ln -sf "$PWD"/gitconfig ~/.gitconfig
mkdir ~/.config
mkdir ~/.config/nvim
ln -sf "$PWD"/nvim/snippets ~/.config/nvim/snippets
ln -sf "$PWD"/nvim/lua ~/.config/nvim/lua
ln -sf "$PWD"/nvim/after/ftplugin ~/.config/nvim/after/ftplugin
ln -sf "$PWD"/nvim/init.lua ~/.config/nvim/init.lua
ln -sf "$PWD"/oh-my-zsh.sh ~/.oh-my-zsh.sh
ln -sf "$PWD"/tmux.conf ~/.tmux.conf
mkdir ~/.config/alacritty
ln -sf "$PWD"/alacritty.yml ~/.config/alacritty/alacritty.yml

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp "$PWD"/cobalt2.zsh-theme ~/.oh-my-zsh/themes
ln -sf "$PWD"/zshrc ~/.zshrc
