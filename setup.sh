#!/bin/bash

clear_all()
{
    kubectl delete --all pods --namespace=default
    kubectl delete --all deployments --namespace=default
    kubectl delete --all services --namespace=default
    minikube addons disable metrics-server
    minikube addons disable ingress
}

redo_service()
{
  kubectl delete deploy $1-deployment
  kubectl delete service $1-service
  eval "$(minikube docker-env)"
  docker rmi -f $1_highforward
  docker build -t $1_highforward srcs/$1/.
  kubectl apply -f srcs/$1.yaml
  printf "IP MINIKUBE = $IP_ADDRESS !"
}

help()
{
    echo "-clear : make minikube clear"
    echo "-space : infos about hard disk"
    echo "-reset ('service') : reboot service with current configuration"
    echo "-ip    : get minikube's ip"
}

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

if [ "$1" = "-clear" ]
then
    clear_all
    printf "All minikube's data cleared"
    exit 0
elif [ "$1" = "-space" ]
then
    du -hd1 ~ | sort -h
    exit 0
elif [ "$1" = "-reset" ]
then
    redo_service $2
    exit 0
elif [ "$1" = "-ip" ]
then
    printf "IP MINIKUBE = $IP_ADDRESS !"
    exit 0
elif [ "$1" = "-help" ]
then
    help
    exit 0
fi

echo $IP_ADDRESS > srcs/ftps/IP_MINIKUBE && echo $IP_ADDRESS > srcs/telegraf/IP_MINIKUBE
echo "UPDATE data_source SET url = 'http://$IP_ADDRESS:8086'" | sqlite3 srcs/grafana/grafana.db

eval $(minikube docker-env)
docker build -t nginx_highforward srcs/nginx
docker build -t mysql_highforward srcs/mysql
docker build -t phpmyadmin_highforward srcs/phpmyadmin
docker build -t wordpress_highforward srcs/wordpress
docker build -t ftps_highforward srcs/ftps
docker build -t grafana_highforward srcs/grafana
docker build -t influxdb_highforward srcs/influxdb
docker build -t telegraf_highforward srcs/telegraf

kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/ingress.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/telegraf.yaml

printf "UP ! > IP = $IP_ADDRESS\n"

#CONNEXION SSH : user@ip -p 30001       | Password = pass
#PHPMYADMIN    : Utilisateur : admin    | Password = pass
#WORDPRESS     : Utilisateur : forward  | Password = pass
#FTP           : Utilisteur  : user     | Password = pass
#GRAFANA       : Utilisteur  : admin    | Password = password