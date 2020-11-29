#
# ENV / SYSTEM
#

# Unlimited history
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=

export GEM_HOME="$HOME/.gem"
export RUBY_HOME=/usr/local/opt/ruby/bin
export PATH="/usr/local/Cellar/gnu-sed/4.5/bin:$RUBY_HOME:$GEM_HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/marianol/Code/go/bin:/Users/marianol/Library/Python/2.7/bin:/Users/marianol/Library/Python/3.7/bin"
export WORKSPACE="$HOME/Code"
export DOTFILES="$WORKSPACE/dotfiles"
export GOPATH="$HOME/Code/go"
#export GOROOT="/usr/local/opt/go/libexec"

# Syntax highlighting in less
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=" -R "

# Use brew's PHP
export PATH="$(brew --prefix php56)/bin:$PATH"

# http://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
export VISUAL=vim

if [ -f ~/.bashrc_work_specific ]; then
    . ~/.bashrc_work_specific
fi

if [ -f ~/.bashrc_temp ]; then
    . ~/.bashrc_temp
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

#
# ALIASES
#

alias ll='ls -la'
alias watch='watch '
alias tree="tree -I 'target|node_modules|vendor'"
alias killmergedbranches='git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d'
alias ctags="$(brew --prefix)/bin/ctags"

# open ports the host is currently listening to
alias ports="lsof -P | grep LISTEN"

# ls last modified files
alias lk='ls -catlnh | head'

alias g="git"
alias s='subl .'
alias d='docker'
alias b='source ~/.bashrc'
alias j='jira'

#
# GIT
#

# git completion
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    GIT_PROMPT_THEME=Custom
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# sql completion
. ~/Code/go/src/github.com/marianogappa/sql/sql-bash-autocomplete

#
# MISC USEFUL
#

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

# https://superuser.com/questions/105499/change-terminal-title-in-mac-os-x
function title {
    echo -ne "\033]0;"$*"\007"
}

# To validate yaml
function yamlok {
    ruby -e "require 'yaml';puts YAML.load_file('$1')" 1>/dev/null 2>&1
}

# https://stackoverflow.com/questions/5677201/how-to-pipe-stdout-while-keeping-it-on-screen-and-not-to-a-output-file
alias show='tee /dev/tty'

# For headless use
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias m="mysql -hlocalhost -uroot"

function owner {
    echo $1
    git shortlog -sn -- $1
    echo
}

# Uncomment this if need to create travis encrypted env variables
# added by travis gem
#[ -f /Users/marianol/.travis/travis.sh ] && source /Users/marianol/.travis/travis.sh

function every {
    awk -v v=$1 'NR % v == 0'
}

function groupby {
   awk '{arr[$1]+=$2}END {for (key in arr) printf("%s\t%s\n", key, arr[key])}' | sort -nk1,1
}

groupby2 ()
{
        awk '{arr[$1 "\t" $2]+=$3}END {for (key in arr) printf("%s\t%s\n", key, arr[key])}' | sort -nk1,1
}

# Env for https://github.com/marianogappa/gs
export WG_DATA_DIR=~/Code/wgdata
echo 'export PATH="/usr/local/opt/go@1.13/bin:$PATH"' >> ~/.bash_profile

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
