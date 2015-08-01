# Niru Maheswaranathan
# ~/.zshrc file

source ~/.zprezto/init.zsh

# fasd options
eval "$(fasd --init auto)"
export TERM=xterm-256color
export CLICOLOR=1
export LC_CTYPE=en_US.UTF-8 # use unicode

# edit this file
alias erc='$EDITOR ~/.zshrc'
alias src='source ~/.zshrc'

# vim keybindings
set -o vi

# tmux stuff
alias tls='tmux ls'
alias lts='tmux ls'
alias tsl='tmux ls'
alias tma='tmux attach -d -t'
alias tmn='tmux new -s'

# git
alias gs='git st'
alias sg='git st'
alias ga='git add'
alias gu='git pull'

# moving around
alias ..='cd ..'
alias ...='cd ../..'

# grep coloring
export GREP_OPTIONS='--color=auto' # automatically color grep output

# key bindings
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey -v
bindkey '^k' up-history
bindkey '^j' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# vtop
alias vtop="vtop --theme monokai"

# suffix aliases
alias -s py=$EDITOR
alias -s pdf=open

# other
alias clc=clear # more cmd style alias
alias whos='who; date'

# ssh aliases
alias lenna='ssh lenna.stanford.edu'
alias lennax='ssh -CY lenna.stanford.edu'
alias cardinal='ssh -CY cardinal.stanford.edu'
alias tonto='ssh -CY niru@tonto.stanford.edu'

# vim
alias v='$EDITOR'
alias n='nvim'

# matlab
alias matlab='/Applications/Matlab.app/bin/matlab -nodesktop -nosplash'

# ipython
alias ipy='ipython2 --nosep --no-banner --profile=mbp'
alias ipy3='ipython3 --nosep --no-banner --profile=mbp'
alias ipyl='ipython2 --nosep --no-banner --profile=lenna'
alias nb='ipython2 notebook --profile=mbp'
alias nb3='ipython3 notebook --profile=mbp'

# rsync
alias rs='rsync -avz'

# other
alias duf='du -shc * | gsort -h'

# editor
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  export EDITOR="gvim"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export EDITOR="mvim"
  export HOMEBREW_EDITOR="vim"
  export VISUAL="vim"
fi

# PATH stuff
export PATH="/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/opt/X11/bin:/usr/local/git/bin:/usr/local/texlive/2015basic/bin/x86_64-darwin/:/Users/nirum/Library/Haskell/bin"

export LD_LIBRARY_PATH=/opt/OpenBLAS/lib:$LD_LIBRARY_PATH
