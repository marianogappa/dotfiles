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

# Syntax highlighting in less
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=" -R "

# Use brew's PHP
export PATH="$(brew --prefix php56)/bin:$PATH"

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

# https://gist.github.com/noraesae/d8dbbb6a28cd49987a72
function movtogif {
    if [ -z "$3" ]; then
        scale=800
    else
        scale=$3
    fi

    ffmpeg -i "$1" -vf scale=$scale:-1 -r 10 -f image2pipe -vcodec ppm - |\
        convert -delay 5 -layers Optimize -loop 0 - "$2"
}


function title {
    echo -ne "\033]0;"$*"\007"
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

function yamlok {
    ruby -e "require 'yaml';puts YAML.load_file('$1')" 1>/dev/null 2>&1
}

function gg {
    git grep "$1" $(git rev-list --all | head -n1000)
}
