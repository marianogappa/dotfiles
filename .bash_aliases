alias ll='ls -la'
alias watch='watch '
alias server="python -m SimpleHTTPServer"
alias tree="tree -I 'target|node_modules'"
alias killmergedbranches='git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d'

# open ports the host is currently listening to
alias ports="lsof -P | grep LISTEN"

# ls last modified files
alias lk='ls -catlnh | head'

# ls last modified file
alias lst='ls -t1 | head -n1'

# less last modified file
alias view='ls -t1 | head -n1 | xargs less'

alias g="git"
alias s='subl .'
alias d='docker'
alias b='source ~/.bashrc'
alias j='jira'

# more or less useful way to see who usually codes in a certain fashion on a repo
alias superblame="git ls-files | xargs -n1 git blame | grep $1"
