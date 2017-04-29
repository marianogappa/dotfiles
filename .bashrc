#
# ENV / SYSTEM
#

# Unlimited history
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/Users/marianol/Code/go/bin:/Users/marianol/Library/Python/2.7/bin"
export WORKSPACE="$HOME/Code"
export DOTFILES="$WORKSPACE/dotfiles"
export GOPATH="$HOME/Code/go"

# http://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
export VISUAL=vim

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc_work_specific ]; then
    . ~/.bashrc_work_specific
fi

if [ -f ~/.bashrc_temp ]; then
    . ~/.bashrc_temp
fi

#
# GIT
#

# git completion
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    GIT_PROMPT_THEME=Custom
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

#
# DOCKER
#

# deletes all exited Docker containers
function dclean {
    docker rm $(docker ps -aq)
}

# exec into a docker container
function dbash {
    docker exec -ti $1 bash || docker exec -ti $1 sh
}

#
# MISC USEFUL
#

function mhead { head -n $(echo "$(wc -l < $1) - $2" | bc) $1; }

function mos {
    for f in $(seq 1 $(tput li)); do echo; done
    exec mosh-client $@
}

# rsync with progress bar, gzipping, etc
function rs {
    command rsync -avz --progress "$@"
}

# https://github.com/MarianoGappa/jira-cli
source ~/Code/jira-cli/jira.sh

# https://github.com/rupa/z
source ~/Code/z/z.sh
