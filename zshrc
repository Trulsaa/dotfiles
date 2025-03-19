# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen-omp.toml)"
fi

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# This needet to be before fzf-tab
autoload -U compinit
compinit

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git macos docker docker-compose terraform kubectl yarn npm helm ng yarn fzf-tab pass rust)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias lg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias lg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias run="./run"

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
brewinstall() {
  local token
  token=$(brew search --casks /./ | fzf-tmux --query="$1" +m --preview 'brew info --cask {}')

  if [ "x$token" != "x" ]; then
    echo "(I)nstall or open the (h)omepage of $token"
    read input
    if [ $input = "i" ] || [ $input = "I" ]; then
      brew install --cask $token
    fi
    if [ $input = "h" ] || [ $input = "H" ]; then
      brew home $token
    fi
  fi
}

# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
brewuninstall() {
  local token
  token=$(brew list --cask | fzf-tmux --query="$1" +m --preview 'brew info --cask {}')

  if [ "x$token" != "x" ]; then
    echo "(U)ninstall or open the (h)omepage of $token"
    read input
    if [ $input = "u" ] || [ $input = "U" ]; then
      brew uninstall --cask $token
    fi
    if [ $input = "h" ] || [ $token = "H" ]; then
      brew home $token
    fi
  fi
}

# Shell in vim mode
set -o vi
bindkey -M vicmd "k" history-beginning-search-backward
bindkey -M vicmd "j" history-beginning-search-forward

# Load fzf settings
source <(fzf --zsh)
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_CTRL_T_COMMAND"

alias tab-rename="pwd | awk -F/ '{print \$NF}' | xargs tmux rename-window"

# `git` wrapper:
#
#     - `git` with no arguments = `git status`; run `git help` to show what
#       vanilla `git` without arguments would normally show.
#     - `git root` = `cd` to repo root.
#     - `git root ARG...` = evals `ARG...` from the root (eg. `git root ls`).
#     - `git tree` = logs the git history tree
#     - `git ARG...` = behaves just like normal `git` command.
#
function git() {
  if [ $# -eq 0 ]; then
    command git status
  elif [ "$1" = 'root' ]; then
    changeDirectoryToGitRoot "$@"
  elif [ "$1" = 'tree' ]; then
    logGitTree "$@"
  elif [ "$1" = 'prune-branches' ]; then
    pruneBranches
  else
    command git "$@"
  fi
}

function pruneBranches() {
  git branch | grep -v '^*' | xargs git branch -D && git remote prune origin
}

function logGitTree() {
  git log \
    --graph \
    --abbrev-commit \
    --decorate \
    --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' \
    --all
}

function changeDirectoryToGitRoot() {
  shift
  local ROOT
  if [ "$(command git rev-parse --is-inside-git-dir 2>/dev/null)" = true ]; then
    if [ "$(command git rev-parse --is-bare-repository)" = true ]; then
      ROOT="$(command git rev-parse --absolute-git-dir)"
    else
      # Note: This is a good-enough, rough heuristic, which ignores
      # the possibility that GIT_DIR might be outside of the worktree;
      # see:
      # https://stackoverflow.com/a/38852055/2103996
      ROOT="$(command git rev-parse --git-dir)/.."
    fi
  else
    # Git 2.13.0 and above:
    ROOT="$(command git rev-parse --show-superproject-working-tree 2>/dev/null)"
    if [ -z "$ROOT" ]; then
      ROOT="$(command git rev-parse --show-toplevel 2>/dev/null)"
    fi
  fi
  if [ -z "$ROOT" ]; then
    ROOT=.
  fi
  if [ $# -eq 0 ]; then
    cd "$ROOT"
  else
    (cd "$ROOT" && eval "$@")
  fi
}

export KUBE_CONFIG_PATH=~/.kube/config

if [[ ! ":$PATH:" == *":$HOME/go/bin:"* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/go/bin"
fi

export OPENAI_API_KEY=$(pass show openai_api_key)

alias pinentry='pinentry-mac'
