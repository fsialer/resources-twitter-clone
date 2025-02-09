#!/bin/bash

kubectl create namespace dev

kubectl apply -f configmap.yml -n dev

#kubectl apply -f secret.yml -n dev

kubectl apply -f azure-keyvault-secret.yml -n dev

kubectl create configmap postgres-init-sql --from-file=init-db.sql -n dev

kubectl apply -f postgres-pv.yml -n dev
kubectl apply -f mongo-pv.yml -n dev

kubectl apply -f postgres-pvc.yml -n dev
kubectl apply -f mongo-pvc.yml -n dev

kubectl apply -f postgres-deploy.yml -n dev
kubectl apply -f mongo-deploy.yml -n dev

kubectl apply -f postgres-svc.yml -n dev
kubectl apply -f mongo-svc.yml -n dev

kubectl apply -f users-deploy.yml -n dev
kubectl apply -f posts-deploy.yml -n dev
kubectl apply -f comments-deploy.yml -n dev
kubectl apply -f likes-deploy.yml -n dev
kubectl apply -f followers-deploy.yml -n dev
kubectl apply -f notifications-deploy.yml -n dev

kubectl apply -f users-svc.yml -n dev
kubectl apply -f posts-svc.yml -n dev
kubectl apply -f comments-svc.yml -n dev
kubectl apply -f likes-svc.yml -n dev
kubectl apply -f followers-svc.yml -n dev
kubectl apply -f notifications-svc.yml -n dev

kubectl apply -f authorization-deploy.yml -n dev
kubectl apply -f gateway-deploy.yml -n dev

kubectl apply -f authorization-svc.yml -n dev
kubectl apply -f gateway-svc.yml -n dev