#!/bin/bash
kubectl create namespace development

kubectl apply -f configmap-dev.yml

kubectl apply -f azure-keyvault-secret-provider.yml

kubectl apply -f postgres-dev-pv.yml
kubectl apply -f mongo-posts-dev-pv.yml
kubectl apply -f mongo-comments-dev-pv.yml
kubectl apply -f mongo-likes-dev-pv.yml
kubectl apply -f mongo-followers-dev-pv.yml
kubectl apply -f mongo-notifications-dev-pv.yml

kubectl apply -f postgres-dev-pvc.yml
kubectl apply -f mongo-posts-dev-pvc.yml
kubectl apply -f mongo-comments-dev-pvc.yml
kubectl apply -f mongo-likes-dev-pvc.yml
kubectl apply -f mongo-followers-dev-pvc.yml
kubectl apply -f mongo-notifications-dev-pvc.yml

kubectl apply -f postgres-dev-deploy.yml
kubectl apply -f mongo-posts-dev-deploy.yml
kubectl apply -f mongo-comments-dev-deploy.yml
kubectl apply -f mongo-likes-dev-deploy.yml
kubectl apply -f mongo-followers-dev-deploy.yml
kubectl apply -f mongo-notifications-dev-deploy.yml

kubectl apply -f postgres-dev-svc.yml
kubectl apply -f mongo-posts-dev-svc.yml
kubectl apply -f mongo-comments-dev-svc.yml
kubectl apply -f mongo-likes-dev-svc.yml
kubectl apply -f mongo-followers-dev-svc.yml
kubectl apply -f mongo-notifications-dev-svc.yml

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

kubectl apply -f authorization-dev-svc.yml

kubectl apply -f gateway-dev-deploy.yml

kubectl apply -f gateway-dev-svc.yml

kubectl apply -f ingress-dev.yml
