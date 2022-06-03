# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"

autoload -Uz compinit && compinit
zmodload -i zsh/complist
setopt complete_aliases

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/node@16/bin"
export PATH="$PATH:$HOME/.rbenv/bin"
export PATH="$PATH:/opt/puppetlabs/bin"
export PATH="$PATH:/Users/craig.gumbley/.puppetlabs/pct"
export PATH="$PATH:/Users/craig.gumbley/.puppetlabs/prm"

# ZSH
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

alias git="gitWrapper"
alias cat="bat"
alias tf="terraform"
alias ls="exa --icons --all"
alias ll="ls --header --long --git"
alias tree="ll --tree --level=4 --ignore-glob='.git'"
alias bolt="/opt/puppetlabs/bin/bolt"
alias vim="nvim"

eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "${HOME}/.fzf.zsh" && source "${HOME}/.fzf.zsh"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
