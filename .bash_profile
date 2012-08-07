# Ambidextrous - useful aliases
alias ls='ls -aG'
alias lit='ssh ravi@lit09.csci.unt.edu'
alias python='python2.7'
alias clj='/Users/ambidextrous/Coding/Clojure/clj'

# Ambidextrous - added for specialized prompt
export PS1='\[\e[33m\][Host \h] \[\e[0;41m\][Jobs \j] \[\e[0;42m\][CWD \w]\[\e[0m\]\n\[\033[1;32m\]\u\[\033[1;36m\] @\[\033[1;31m\]Zion \[\033[0m\]$ '
#export PS1='\u @ Zion $ '


# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

##
# Your previous /Users/ambidextrous/.bash_profile file was backed up as /Users/ambidextrous/.bash_profile.macports-saved_2012-04-19_at_16:46:18
##

# MacPorts Installer addition on 2012-04-19_at_16:46:18: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

