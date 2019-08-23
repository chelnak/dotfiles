#  Start in code directory if shell
if status is-interactive

  cd $HOME/code

end

# Merge kubeconfig files
set_kubeconfig

# Load aliases
if [ -f ~/.kubectl_aliases ]
   source ~/.kubectl_aliases
end
