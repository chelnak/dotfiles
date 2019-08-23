function set_kubeconfig
  set -e KUBECONFIG
  for x in $HOME/.kube/*
    if test -f $x
      if test -z "$KUBECONFIG"
        set -g -x KUBECONFIG $x
      else
        set -g -x KUBECONFIG "$KUBECONFIG:$x"
      end
    end
  end
  echo "KUBECONFIG updated:" $KUBECONFIG
end