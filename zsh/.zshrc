export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/node@16/bin:$PATH"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias git="gitWrapper"
alias cat="bat"
alias tf="terraform"

eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(rbenv init -)"
eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

