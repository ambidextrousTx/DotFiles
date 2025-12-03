# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ambidextrous: Powerlevel10k recommends against console output when using instant prompt
#echo "Welcome to Olympus, Ambidextrous"
#echo ""
#echo -n "Today is "; date "+%m-%d-%Y %H:%M:%S"
#echo -n "System status: "; uptime

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

# Path to the oh-my-zsh configuration.
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

ZSH_THEME="powerlevel10k/powerlevel10k"

# Ambidextrous - useful aliases
alias ls='ls -a'
alias ec='/usr/local/bin/ctags'
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias hh='history | egrep -i'
alias up='cd ..'

# Grc - for colorizing terminal output
# /opt/homebrew/etc/grc.conf has the regexes and their colors defined
alias grc='grc -es --colour=on'

# Useful shell options
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

# Helpful functions
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

# Convert a man page into PostScript and view it in Preview
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
plugins=(ant man spring sublime sudo mvn battery bower nmap brew gem node git git-extras npm macos pep8 github perl gnu-utils go golang tmux postgres gradle colored-man-pages grails colorize grunt gulp vagrant history pylint python rake jsontools react-native redis-cli xcode docker rsync lein scala sbt zsh-syntax-highlighting zsh-autosuggestions)

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ambidextrous/Coding/Python/Anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ambidextrous/Coding/Python/Anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ambidextrous/Coding/Python/Anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ambidextrous/Coding/Python/Anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# Ambidextrous: do not activate conda's base environment on startup, i.e.
# do not show (base) in the prompt unless explicitly desired
# eval "conda config --set auto_activate_base false"

nvm() {
    unset -f nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm "$@"
}

# Ambidextrous: Need Ruby 3.1+ for Cocoapods, default Darwin Ruby is Ruby 2
# Homebrew Ruby needs manual path
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
# Have compilers and package configs find Homebrew Ruby
export LDFLAGS="-L/opt/homebrew/opt/ruby@3.3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby@3.3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby@3.3/lib/pkgconfig"
# Homebrew Ruby's gems are the way to go
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"

# For uv-installed binaries
export PATH="/Users/ambidextrous/.local/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
