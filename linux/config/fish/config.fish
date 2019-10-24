#  Start in code directory if shell
if status is-interactive

  cd $HOME/code

end

set -x GOPATH $HOME/work
set PATH $PATH:/usr/local/go/bin:$GOPATH/bin

# Merge kubeconfig files
set_kubeconfig

# Load aliases
if [ -f ~/.kubectl_aliases ]
   source ~/.kubectl_aliases
end
