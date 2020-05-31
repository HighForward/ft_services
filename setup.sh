#!/bin/sh

clear_all()
{
    kubectl delete --all pods --namespace=default
    kubectl delete --all deployments --namespace=default
    kubectl delete --all services --namespace=default
    minikube addons disable metrics-server
    minikube addons disable ingress
}

if [ "$1" = "-clear" ]
then
    clear_all
    printf "All minikube's data cleared"
    exit 0
elif [ "$1" = "-space" ]
then
    du -hd1 ~ | sort -h
    exit 0
fi

if ! minikube status >/dev/null 2>&1
then
    printf "Starting minikube...\n"
    if ! minikube start --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-35000
    then
        printf "Minikube cannot start !\n"
        exit 1
    fi
    minikube addons enable metrics-server
    minikube addons enable ingress
fi

IP_ADDRESS=$(minikube ip)

if [ "$IP_ADDRESS" = "127.0.0.1" ]
then
	IP_ADDRESS="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
fi

eval $(minikube docker-env)
docker build -t nginx_highforward srcs/nginx
docker build -t mysql_highforward srcs/mysql
docker build -t phpmyadmin_highforward srcs/phpmyadmin
docker build -t wordpress_highforward srcs/wordpress

kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/ingress.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/wordpress.yaml

printf "UP ! > IP = $IP_ADDRESS\n"

#CONNEXION SSH : user@ip -p 30001       | Password = pass
#PHPMYADMIN    : Utilisateur : admin    | Password = pass
#WORDPRESS     : Utilisateur : forward  | Password = pass