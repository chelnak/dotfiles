# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
autoload -Uz compinit && compinit
zmodload -i zsh/complist
setopt complete_aliases

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/node@16/bin"
export PATH="$PATH:$HOME/.rbenv/shims"
export PATH="$PATH:$HOME/.rbenv/bin"
export PATH="$PATH:/opt/puppetlabs/bin"
export PATH="$PATH:/Users/craig.gumbley/.puppetlabs/pct"
export PATH="$PATH:/Users/craig.gumbley/.puppetlabs/prm"
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
alias tf="terraform"
alias ls="exa --icons --all"
alias ll="ls --header --long --git"
alias tree="ll --tree --level=4 --ignore-glob='.git'"
alias bolt="/opt/puppetlabs/bin/bolt"
alias vim="nvim"
alias dotfiles="cd $HOME/.dotfiles"

eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(starship init zsh)"

test -e "${HOME}/.fzf.zsh" && source "${HOME}/.fzf.zsh"

set_terminal_title

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
