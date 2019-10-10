FROM alpine:3.10

# Install basics
RUN apk update && apk add -U --no-cache \
    bash \
    git \
    neovim \
    curl \
    the_silver_searcher

ENV HOME /

# Configure text editor - neovim!
RUN curl -fLo ${HOME}/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Consult the vimrc file to see what's installed
COPY init.vim ${HOME}/.config/nvim/init.vim
# Clone the git repos of Vim plugins
WORKDIR ${HOME}/.config/nvim/plugged/

RUN echo "clone vim plugins" && \
    git clone --depth=1 https://github.com/jiangmiao/auto-pairs && \
    git clone --depth=1 https://github.com/tpope/vim-vinegar && \
    git clone --depth=1 https://github.com/tpope/vim-commentary && \
    git clone --depth=1 https://github.com/tpope/vim-repeat && \
    git clone --depth=1 https://github.com/tpope/vim-surround && \
    git clone --depth=1 https://github.com/yuttie/comfortable-motion.vim && \
    git clone --depth=1 https://github.com/christoomey/vim-tmux-navigator && \
    git clone --depth=1 https://github.com/sickill/vim-pasta && \
    git clone --depth=1 https://github.com/Yggdroot/indentLine && \
    git clone --depth=1 https://github.com/wincent/loupe && \
    git clone --depth=1 https://github.com/mattn/webapi-vim && \
    git clone --depth=1 https://github.com/wincent/terminus && \
    git clone --depth=1 https://github.com/vim-scripts/vim-auto-save && \
    git clone --depth=1 https://github.com/ntpeters/vim-better-whitespace && \
    git clone --depth=1 https://github.com/editorconfig/editorconfig-vim && \
    git clone --depth=1 https://github.com/tpope/vim-projectionist && \
    git clone --depth=1 https://github.com/machakann/vim-highlightedyank && \
    git clone --depth=1 https://github.com/janko-m/vim-test && \
    git clone --depth=1 https://github.com/vim-scripts/ReplaceWithRegister && \
    git clone --depth=1 https://github.com/kana/vim-textobj-indent && \
    git clone --depth=1 https://github.com/kana/vim-textobj-line && \
    git clone --depth=1 https://github.com/kana/vim-textobj-user && \
    git clone --depth=1 https://github.com/junegunn/fzf.vim && \
    git clone --depth=1 https://github.com/airblade/vim-gitgutter && \
    git clone --depth=1 https://github.com/tpope/vim-fugitive && \
    git clone --depth=1 https://github.com/shumphrey/fugitive-gitlab.vim && \
    git clone --depth=1 https://github.com/tpope/vim-rhubarb && \
    git clone --depth=1 https://github.com/altercation/vim-colors-solarized && \
    git clone --depth=1 https://github.com/vim-airline/vim-airline && \
    git clone --depth=1 https://github.com/vim-airline/vim-airline-themes && \
    git clone --depth=1 https://github.com/edkolev/tmuxline.vim


# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf && ${HOME}/.fzf/install --all

# Copy git config over
COPY gitconfig ${HOME}/.gitconfig

# Set working directory to /workspace
WORKDIR /workspace

# Default entrypoint, can be overridden
CMD ["nvim"]
