echo "Welcome to Olympus, Ambidextrous"
echo ""
echo -n "Today is "; date "+%m-%d-%Y %H:%M:%S"
echo -n "System status: "; uptime

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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

# Ambidextrous: changed, Jun 24, 2013
# For enabling interactive plotting
# alias ipython='ipython --pylab'

# Ambidextrous - grc - for colorizing terminal output
# /usr/local/etc/grc.conf has the regexes and their colors defined
alias grc='grc -es --colour=on'

# Ambidextrous - git aliases
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gl='git log'

# Ambidextrous - tmux aliases
alias ta='tmux attach'
alias tl='tmux ls'
alias tn='tmux new -s'

# Ambidextrous - Scala REPL has colors starting from 2.11.4
# Apparently the new Scala versions do this by default and this thing doesn't work anymore
#alias scala='scala -Dscala.color'

# Ambidextrous - Useful shell options
# Do not overwrite a file through stdout redirect if file exists
set -o noclobber

# Ignore commands that start with a space. Ignore repeated duplicates
HISTCONTROL=ignorespace:ignoredups

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
plugins=(ant man spring sublime sudo mvn battery bower nmap brew gem node git git-extras npm osx pep8 github perl gnu-utils go golang tmux postgres gradle colored-man-pages grails colorize grunt gulp vagrant command-not-found history pylint python rails rake jsontools react-native redis-cli xcode docker rsync lein scala sbt aws zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Ambidextrous: putting Macports Python version at the beginning so that pyrg works
export PATH=/Users/ambidextrous/Coding/Python/Anaconda3/bin:/opt/local/bin:/opt/local/sbin:Users/ambidextrous/Coding/Scripts:/usr/local/smlnj/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/texbin:/usr/X11/bin:/usr/local/go/bin

# Ambidextrous: use MacVim for Vmail instead of the terminal Vim
export PATH=/Applications:$PATH
export VMAIL_VIM=mvim

# Ambidextrous: updating path to include npm-installed binaries
export PATH=/usr/local/share/npm/bin:/usr/local/share/npm/lib/node_modules:/usr/local/lib/node_modules:$PATH

# Ambidextrous: Adding all the tools supplied with the Data Science
# at the Command Line book
export PATH=$PATH:/Users/ambidextrous/Coding/DataScienceCLI/data-science-at-the-command-line/tools

# Ambidextrous: For third party Go libraries/ binaries
export GOPATH=/Users/ambidextrous/Coding/GoLang/lib
export PATH=$PATH:/Users/ambidextrous/Coding/GoLang/lib/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# Ambidextrous: Tapkee executables
export PATH=$PATH:/Users/ambidextrous/Coding/Tapkee/tapkee-master/bin

# Ambidextrous: Homebrew puts stuff in /usr/local/sbin too
export PATH="/usr/local/sbin:$PATH"

# Ambidextrous: Path to Factor
export PATH=/Applications/factor:$PATH

# Ambidextrous: Ruby specific
export RI="--format ansi --width 70"

# Ambidextrous: OS X specific system utilities
alias ssid='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep SSID'
alias tunnel2cadmius="ssh -L 5901:127.0.0.1:5901 -N -f -l ravisinha Cadmius.local"

# Ambidextrous: for the new Theano through a different channel
export DYLD_FALLBACK_LIBRARY_PATH=/Users/ambidextrous/Coding/Python/Anaconda3/lib:$DYLD_FALLBACK_LIBRARY_PATH

# Ambidextrous: shortcut to code-maat from Adam Tornhill
alias maat='java -jar target/code-maat-0.9.2-SNAPSHOT-standalone.jar'

# Ambidextrous: added from the Pro Vim book courtesy of Mark McDonnell
export GREP_OPTIONS='--color=auto'
export MANPAGER='less -X' # Don't clear the screen upon quitting a man page

# Ambidextrous: starting using Starship as the prompt Dec 2020
eval "$(starship init zsh)"

