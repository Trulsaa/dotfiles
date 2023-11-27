# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cobalt2"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git macos docker docker-compose terraform kubectl yarn npm helm ng yarn fzf-tab pass)

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
alias kontoret='displayplacer "id:4FD644F6-ECC9-C033-8962-76FEA756A762 res:1792x1120 hz:59 color_depth:8 scaling:on origin:(0,0) degree:0" "id:2C54366F-0D6B-978E-A695-C6256DE17B42 res:3440x1440 hz:50 color_depth:8 scaling:off origin:(0,-1440) degree:0"'
alias hjemme='displayplacer "id:4FD644F6-ECC9-C033-8962-76FEA756A762 res:1792x1120 hz:59 color_depth:8 scaling:on origin:(0,0) degree:0" "id:827F7224-9EBA-B60B-DDDD-13BAFAC592BF res:3440x1440 hz:50 color_depth:8 scaling:off origin:(1792,-153) degree:0"'

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
brewinstall() {
    local token
    token=$(brew search --casks /./ | fzf-tmux --query="$1" +m --preview 'brew info --cask {}')

    if [ "x$token" != "x" ]
    then
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

    if [ "x$token" != "x" ]
    then
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
bindkey -v

bindkey '^?' backward-delete-char
export KEYTIMEOUT=1
bindkey -M vicmd "k" history-beginning-search-backward
bindkey -M vicmd "j" history-beginning-search-forward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="[NORMAL]"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Load fzf settings
set -o vi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_CTRL_T_COMMAND"

alias tab-rename="pwd | awk -F/ '{print \$NF}' | xargs tmux rename-window"

export JAVA_HOME=/usr/local/opt/openjdk@17

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
  if [ "$(command git rev-parse --is-inside-git-dir 2> /dev/null)" = true ]; then
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
    ROOT="$(command git rev-parse --show-superproject-working-tree 2> /dev/null)"
    if [ -z "$ROOT" ]; then
      ROOT="$(command git rev-parse --show-toplevel 2> /dev/null)"
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

function alvtime() {
  export ALVTIME_TOKEN="$(awk 'NR==1{ print $1 }' ~/.alvtime)"
  local ALVTIME_TOKEN_EXPIRY="$(awk 'NR==1{ print $2 }' ~/.alvtime)"

  # Run brew install dateutils to install datetest and others
  datetest "$(date +'%Y-%m-%d')" --gt "$ALVTIME_TOKEN_EXPIRY" \
    && echo "Alvtime token has expired" \
    && return 1

  if [ "$#" -eq 0 ]; then
    echo "
Alvtime CLI wrapper

register syk 3.5                : Registers 3.5 hours to task id 14 today
week ferie 7.5                  : Register 7.5 hours to task 14 every working day this week
multiregister data.txt          : Takes a file name or stdin of line with 'date taskid hours'
hours [yyyy-mm-dd [yyyy-mm-dd]] : Prints the registerd hours between the two dates.
                                  Dates default to monday and sunday in the current week
tasks                           : Prints all tasks
profile                         : Fetch user profile
availableHours
flexedHours
payouts
holidays [year]                 : Returns the alv holidays in a year. Defaults to current year
ping                            : Check if the api is alive
"
  fi

  # If $2 is not a number replace it with the matching number from config
  if [ "$1" = week ] || [ "$1" = register ]; then
    RE='^[0-9]+$'
    if ! [[ "$2" =~ $RE ]] ; then
      local ID="$(grep -i "${2}$" ~/.alvtime | awk '{print $1}')"
      set -- "$1" "$ID" "$3" "$4"
    fi
  fi

  if [ "$1" = week ]; then
    alvtimeWeek "$@"
  elif [ "$1" = hours ]; then
    alvtimeHours "$@"
  elif [ "$1" = tasks ]; then
    alvtimeTasks "$@"
  elif [ "$1" = register ]; then
    ~/Projects/alv/alvtime/packages/shell/alvtime.sh "$@" > /dev/null
    alvtime hours
  else
    ~/Projects/alv/alvtime/packages/shell/alvtime.sh "$@"
  fi

  return 0
}

function alvtimeWeek() {
  shift
  HOLIDAYS_TEMPFILE="$(mktemp)"
  trap "rm $HOLIDAYS_TEMPFILE" EXIT
  ~/Projects/alv/alvtime/packages/shell/alvtime.sh holidays | jq -r '.[]' > $HOLIDAYS_TEMPFILE
  MON=$(date -v -Mon +'%Y-%m-%d')
  FRI=$(dateadd "$MON" +4d)
  dateseq "$MON" "$FRI" \
    | grep -v -x -F -f "$HOLIDAYS_TEMPFILE" \
    | awk -v id="$1" -v hours="$2" '{print $0 " " id " " hours}' \
    | ~/Projects/alv/alvtime/packages/shell/alvtime.sh multiregister > /dev/null
  alvtime hours
}

function alvtimeHours() {
  shift
  MON=$(date -v -Mon +'%Y-%m-%d')
  SUN=$(dateadd "$MON" +6d)
  FROM_DATE_INCLUSIVE="${1:-$MON}"
  TO_DATE_INCLUSIVE="${2:-$SUN}"
  ~/Projects/alv/alvtime/packages/shell/alvtime.sh hours "$FROM_DATE_INCLUSIVE" "$TO_DATE_INCLUSIVE" \
    | ~/Projects/dotfiles/alvtime/hours.js
}

function alvtimeTasks() {
  shift
  local TASK=$(~/Projects/alv/alvtime/packages/shell/alvtime.sh tasks \
    | jq -r '.[] | "\(.id) \(.project.customer.name) \(.project.name) \(.name)"' \
    | fzf-tmux +m)

  local ID=$(echo $TASK | awk '{print $1}')
  echo "Write ref name to save the task to favorites. Leave blank to to not save:"
  read INPUT
  test -n "$INPUT" \
    && echo "$ID $INPUT" \
    && echo "$ID $INPUT" >> ~/.alvtime || true
}

export KUBE_CONFIG_PATH=~/.kube/config

export JDTLS_HOME="$HOME/bin/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository"

if [[ ! ":$PATH:" == *":$HOME/go/bin:"* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/go/bin"
fi

export OPENAI_API_KEY=$(pass show openai_api_key)

alias pinentry='pinentry-mac'
