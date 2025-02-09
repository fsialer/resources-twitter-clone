#!/bin/bash

kubectl create namespace dev

kubectl apply -f configmap-dev.yml

kubectl apply -f secret.yml

#kubectl apply -f azure-keyvault-secret.yml

kubectl create configmap postgres-init-sql --from-file=init-db.sql -n dev

kubectl apply -f postgres-dev-pv.yml
kubectl apply -f mongo-pv.yml

kubectl apply -f postgres-dev-pvc.yml
kubectl apply -f mongo-pvc.yml

kubectl apply -f postgres-dev-deploy.yml
kubectl apply -f mongo-deploy.yml

kubectl apply -f postgres-dev-svc.yml
kubectl apply -f mongo-svc.yml

kubectl apply -f users-dev-deploy.yml
kubectl apply -f posts-dev-deploy.yml
kubectl apply -f comments-dev-deploy.yml
kubectl apply -f likes-dev-deploy.yml
kubectl apply -f followers-dev-deploy.yml
kubectl apply -f notifications-dev-deploy.yml

kubectl apply -f users-dev-svc.yml
kubectl apply -f posts-dev-svc.yml
kubectl apply -f comments-dev-svc.yml
kubectl apply -f likes-dev-svc.yml
kubectl apply -f followers-dev-svc.yml
kubectl apply -f notifications-dev-svc.yml

kubectl apply -f authorization-dev-deploy.yml
kubectl apply -f gateway-dev-deploy.yml

kubectl apply -f authorization-dev-svc.yml
kubectl apply -f gateway-dev-svc.yml