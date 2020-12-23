kubectl get pods --no-headers=true | awk '/spark/{print $1}' | xargs  kubectl delete pod
