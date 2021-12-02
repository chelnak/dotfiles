export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.rbenv/bin:$PATH"

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias cat="catz"
alias docker="nerdctl"
alias tf="terraform"

eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(starship init zsh)"

