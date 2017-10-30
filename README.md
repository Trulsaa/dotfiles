# README

## TODO

- [ ] Write install script
    - [ ] Create path variable
    - [ ] Symlinks
    - [ ] install plugins
    - [ ] ???

## Dependencies

1. Homebrew - `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. node & npm - `brew install node`

### For neovim

1. Install neovim - `brew install neovim`
1. Install pip3 - `brew install python3`
1. Support for python plugins in Nvim - `pip3 install neovim`

### For fzf preview window highlighting

- `brew install highlight`
- `gem install coderay`
- `gem install rougify`

### Ctags

- `brew install ctags`

### Neomake

- For html linting `brew install tidy-html5`
- For json file linting using Neomake `npm install jsonlint -g`
- For vim script linting `pip3 install vim-vint`
- For bash/sh linting `brew install shellcheck`
