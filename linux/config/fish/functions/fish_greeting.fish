function fish_greeting

    set GREENARROW (set_color green)➜
    set NORMAL (set_color normal)
    set SUBSCRIPTION (az account show --query 'name' -o tsv)
    set KUBECTX (kubectl config current-context)
    set IP (hostname -I)

    echo '#######################################'
    echo $GREENARROW $NORMAL az: $SUBSCRIPTION
    echo $GREENARROW $NORMAL k8s: $KUBECTX
    echo $GREENARROW $NORMAL ip: $IP
    echo '#######################################'
    echo ''

end
