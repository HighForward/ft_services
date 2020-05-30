# delete all docker's data
# docker system prune -a

# delete all pods
kubectl delete --all pods --namespace=default

# deete all deployments
kubectl delete --all deployments --namespace=default

# delete all services
kubectl delete --all services --namespace=default

#disable ingress
minikube addons disable ingress
