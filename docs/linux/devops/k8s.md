## helm
## index.yaml

## k8s
### 新加权限
https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
https://kubernetes.io/zh/docs/reference/access-authn-authz/rbac/#kubectl-auth-reconcile
https://kubernetes.io/zh/docs/reference/access-authn-authz/rbac/#kubectl-create-role
https://kubernetes.io/zh/docs/reference/access-authn-authz/rbac/#kubectl-create-clusterrolebinding

```sh
kubectl create sa nighting-build
kubectl create clusterrolebinding nighting-build --clusterrole=nighting-build --serviceaccount=nighting-build:nighting-build
kubectl create clusterrole nighting-build --verb=get,list,watch,patch,create,update --resource=deployment,configmap,service,ingress
```
### 使用serviceaccount的token链接集群
SECRET_TOKEN=$(kubectl get sa ${K8SUSERNAME} -o jsonpath='{.secrets[0].name}')
export SA_TOKEN=$(kubectl get secret ${SECRET_TOKEN} -o jsonpath={.data.token} -n sa-test | base64 -d)

SA_TOKEN=$(kubectl get secret ${SECRET_TOKEN} -o jsonpath={.data.token} -n default | base64 -d)


kubectl config set-credentials ${K8SUSERNAME} --token=${SA_TOKEN}


kubectl config set-context ${K8SUSERNAME} --cluster=cls-4pp6s10w--namespace=default --user=${K8SUSERNAME}



kubectl rolling-update myapp --image=us.gcr.io/project-107012/myapp:5c3dda6b

kubectl set image -n dev deployment

