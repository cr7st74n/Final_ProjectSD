#!/bin/bash

echo "Ì¥• Starting Minikube..."
minikube start

echo "Ì≥¶ Applying ConfigMap..."
kubectl apply -f k8s/mysql-configmap.yaml

echo "Ì≤æ Applying Persistent Volume and Claim..."
kubectl apply -f k8s/mysql-pv.yaml
kubectl apply -f k8s/mysql-pvc.yaml

echo "Ì∞¨ Deploying MySQL..."
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/mysql-service.yaml

echo "Ì±∑ Deploying Jenkins..."
kubectl apply -f k8s/jenkins-deployment.yaml
kubectl apply -f k8s/jenkins-service.yaml

echo "Ì≥¶ Deploying Nexus..."
kubectl apply -f k8s/nexus-deployment.yaml
kubectl apply -f k8s/nexus-service.yaml

echo "Ì∫Ä Deploying Webapp..."
kubectl apply -f k8s/webapp-deployment.yaml
kubectl apply -f k8s/webapp-service.yaml

echo "Ì¥ç Checking resources..."
kubectl get configmap
kubectl get pv
kubectl get pvc
kubectl get pods
kubectl get svc

echo " Deployment complete!"

