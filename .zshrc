echo "Welcome to Olympus, Ambidextrous"
echo ""
echo -n "Today is "; date "+%m-%d-%Y %H:%M:%S"
echo -n "System status: "; uptime

# Ambidextrous: Homebrew on Apple Silicon
CPU=$(uname -p)
if [[ "$CPU" == "arm" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/sbin:$PATH"
    export BREW_BASE="/opt/homebrew"
    alias oldbrew=/usr/local/bin/brew
else
    export PATH="/usr/local/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
    export BREW_BASE="/usr/local"
fi

# Superior editing experience
set -o vi
export EDITOR=nvim
export VISUAL=nvim

# Anaconda first, the path to Homebrew set above next, then everything else
export PATH=/Users/ambidextrous/Coding/Python/Anaconda3/bin:$PATH:/opt/local/bin:/opt/local/sbin:Users/ambidextrous/Coding/Scripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/texbin:/usr/X11/bin:

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Adding this allows us to run `zprof` on the command line, which profiles all the
# commands run in the current session and displays the times taken
zmodload zsh/zprof

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#
# Experimenting with random themes
# ZSH_THEME="random"

ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Ambidextrous - useful aliases
alias ls='ls -a'
alias ec='/usr/local/bin/ctags'
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias hh='history | egrep -i'
alias up='cd ..'

# Ambidextrous - grc - for colorizing terminal output
# /opt/homebrew/etc/grc.conf has the regexes and their colors defined
alias grc='grc -es --colour=on'

# Ambidextrous - Kubernetes-specific
alias k='kubectl'

# Ambidextrous - Useful shell options
# Do not overwrite a file through stdout redirect if file exists
set -o noclobber

# Ignore commands that start with a space. Ignore repeated duplicates
HISTCONTROL=ignorespace:ignoredups

# Other history settings
HISTTIMEFORMAT="%m/%d/%y %T"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS     # Don't save duplicate lines
setopt SHARE_HISTORY        # Share history between sessions

# Ambidextrous - helpful functions
# Change directory and list items
function cl {
    ls='ls -a'
    cd $1
    eval $ls
}

# 'Discover' something within the text of the files in
# a directory structure and color-print it
function disc {
    cmd='find . * | xargs egrep --color=always $1'
    eval $cmd
}

# 'IsThere' something in the files in a directory that
# matches the string case-insensitively?
function isthere {
    cmd='ls | egrep -i $1'
    eval $cmd
}

# Ambidextrous - convert a man page into PostScript and view it in Preview
# Works only on Mac OS X
function niceman {
    cmd='man -t $1 | open -fa Preview'
    eval $cmd
}

function teleport {
    mkdir -p $1
    cd $1
}

# From Mischa van den Burg
# List path members for easy reading
# Useful for discovering duplication
#
# zsh-specific glob setting
setopt extended_glob null_glob

# zsh provides contents of PATH as an array called path
# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))
export PATH

function getpath {
    echo -e ${PATH//:/\\n}
}

# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
# Measure the shell's load time
function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

# Extremely slow plugins - aws and command-not-found - have been removed
plugins=(kubectl ant man spring sublime sudo mvn battery bower nmap brew gem node git git-extras npm macos pep8 github perl gnu-utils go golang tmux postgres gradle colored-man-pages grails colorize grunt gulp vagrant history pylint python rake jsontools react-native redis-cli xcode docker rsync lein scala sbt zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Ambidextrous: use MacVim for Vmail instead of the terminal Vim
export PATH=/Applications:$PATH
export VMAIL_VIM=mvim

# Ambidextrous: Adding all the tools supplied with the Data Science
# at the Command Line book
export PATH=$PATH:/Users/ambidextrous/Coding/DataScienceCLI/data-science-at-the-command-line/tools

# Ambidextrous: For third party Go libraries/ binaries
export GOPATH=/Users/ambidextrous/Coding/GoLang/lib
export PATH=$PATH:/Users/ambidextrous/Coding/GoLang/lib/bin
export PATH=$PATH:${BREW_BASE}/opt/go/libexec/bin

# Ambidextrous: Path to Factor
export PATH=/Applications/factor:$PATH

# Ambidextrous: Path to Rust
export PATH=~/.cargo/bin:$PATH

# Ambidextrous: Ruby specific
export RI="--format ansi --width 70"

# Ambidextrous: OS X specific system utilities
alias ssid='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep SSID'

# Ambidextrous: added from the Pro Vim book courtesy of Mark McDonnell
export GREP_OPTIONS='--color=auto'
export MANPAGER='less -X' # Don't clear the screen upon quitting a man page

# Ambidextrous: starting using powerline-shell as the prompt June 2022
function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" -a -x "$(command -v powerline-shell)" ]; then
    install_powerline_precmd
fi

# >>> conda initialize >>>
# Removed block added by Conda/Anaconda because it slows down the
# shell startup by 3-10 seconds
# May be added back if needed
# See https://github.com/ContinuumIO/anaconda-issues/issues/10173
# See https://github.com/conda/conda/issues/7855
# <<< conda initialize <<<
#
# Ambidextrous: do not activate conda's base environment on startup, i.e.
# do not show (base) in the prompt unless explicitly desired
# eval "conda config --set auto_activate_base false"
