#!/bin/bash

# Crear una Managed Identity
az identity create --name twitter-clone-keyvault-aks --resource-group gr-twitterclone
# Obtener el CLIENT_ID de la Managed Identity
MI_CLIENT_ID=$(az identity show --name twitter-clone-keyvault-aks --resource-group gr-twitterclone --query 'clientId' -o tsv)

# Otorgar acceso a Key Vault

az keyvault set-policy --name twitter-clone-vault --resource-group gr-twitterclone \
    --secret-permissions get list --spn $MI_CLIENT_ID

kubectl create namespace dev

kubectl apply -f configmap-dev.yml

kubectl apply -f secret.yml

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