autoload -Uz compinit && compinit
zmodload -i zsh/complist
setopt complete_aliases

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/node@16/bin"
export PATH="$PATH:$HOME/.rbenv/shims"
export PATH="$PATH:$HOME/.rbenv/bin"
export PATH="$PATH:/opt/puppetlabs/bin"
export ZSH="$HOME/.oh-my-zsh"
export=ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

DISABLE_AUTO_TITLE="true"
function set_terminal_title() {
    echo -ne "\033]0;$(basename ${PWD})\007"
}

plugins=(
    git
    copybuffer
    copypath
    dirhistory
    jsontools
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias git="gitWrapper"
alias cat="bat"
alias ls="exa --icons --all"
alias ll="ls --header --long --git"
alias tree="ll --tree --level=4 --ignore-glob='.git'"
alias bolt="/opt/puppetlabs/bin/bolt"
alias vim="nvim"
alias dotfiles="cd $HOME/.dotfiles"
alias ppt="cd $HOME/code/puppet"
alias gs="git status"
alias gco="git checkout"
alias gcm="git checkout main"
alias gcb="git checkout -b"
alias gpl="git pull"
alias gps="git push"
alias yolo="git add . && git commit --amend --no-edit && git push --force-with-lease"
alias qb='qutebrowser'

eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(starship init zsh)"

test -e "${HOME}/.fzf.zsh" && source "${HOME}/.fzf.zsh"

set_terminal_title
