#!/bin/bash
kubectl create namespace production

kubectl apply -f configmap-prod.yml

kubectl apply -f azure-keyvault-secret-provider.yml

kubectl apply -f postgres-prod-pv.yml
kubectl apply -f mongo-posts-prod-pv.yml
kubectl apply -f mongo-comments-prod-pv.yml
kubectl apply -f mongo-likes-prod-pv.yml
kubectl apply -f mongo-followers-prod-pv.yml
kubectl apply -f mongo-notifications-prod-pv.yml

kubectl apply -f postgres-prod-pvc.yml
kubectl apply -f mongo-posts-prod-pvc.yml
kubectl apply -f mongo-comments-prod-pvc.yml
kubectl apply -f mongo-likes-prod-pvc.yml
kubectl apply -f mongo-followers-prod-pvc.yml
kubectl apply -f mongo-notifications-prod-pvc.yml

kubectl apply -f postgres-prod-deploy.yml
kubectl apply -f mongo-posts-prod-deploy.yml
kubectl apply -f mongo-comments-prod-deploy.yml
kubectl apply -f mongo-likes-prod-deploy.yml
kubectl apply -f mongo-followers-prod-deploy.yml
kubectl apply -f mongo-notifications-prod-deploy.yml

kubectl apply -f postgres-prod-svc.yml
kubectl apply -f mongo-posts-prod-svc.yml
kubectl apply -f mongo-comments-prod-svc.yml
kubectl apply -f mongo-likes-prod-svc.yml
kubectl apply -f mongo-followers-prod-svc.yml
kubectl apply -f mongo-notifications-prod-svc.yml

kubectl apply -f users-prod-deploy.yml
kubectl apply -f posts-prod-deploy.yml
kubectl apply -f comments-prod-deploy.yml
kubectl apply -f likes-prod-deploy.yml
kubectl apply -f followers-prod-deploy.yml
kubectl apply -f notifications-prod-deploy.yml

kubectl apply -f users-prod-svc.yml
kubectl apply -f posts-prod-svc.yml
kubectl apply -f comments-prod-svc.yml
kubectl apply -f likes-prod-svc.yml
kubectl apply -f followers-prod-svc.yml
kubectl apply -f notifications-prod-svc.yml

kubectl apply -f authorization-prod-deploy.yml

kubectl apply -f authorization-prod-svc.yml

kubectl apply -f gateway-prod-deploy.yml

kubectl apply -f gateway-prod-svc.yml
