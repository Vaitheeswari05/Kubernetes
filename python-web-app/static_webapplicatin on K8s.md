# Kubernetes Autoscaling, Auto-Healing, and Static Web App Deployment

## Table of Contents
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Start Minikube](#start-minikube)
- [Deploy a Static Web Application](#deploy-a-static-web-application)
- [Configure Service to Expose Application](#configure-service-to-expose-application)
- [Accessing the Application](#accessing-the-application)
- [Kubernetes Autoscaling](#kubernetes-autoscaling)
- [Auto-Healing with ReplicaSets](#auto-healing-with-replicasets)
- [Troubleshooting](#troubleshooting)

## Introduction
This repository documents the journey of deploying a static web application on Kubernetes (K8s), setting up autoscaling, enabling auto-healing, and troubleshooting common issues encountered along the way.

## Prerequisites
- Installed **Minikube**
- Installed **kubectl**
- Docker installed for building container images
- Basic knowledge of Kubernetes

## Start Minikube
To start Minikube, use the following command:
```sh
minikube start
```

## Deploy a Static Web Application
1. Create a **Deployment YAML** file (`deployment.yaml`) defining the pod, container image, and number of replicas.
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: webapp-deployment
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: webapp
     template:
       metadata:
         labels:
           app: webapp
       spec:
         containers:
           - name: webapp-container
             image: your-docker-image:latest
             ports:
               - containerPort: 8000
   ```
2. Apply the deployment file:
   ```sh
   kubectl apply -f deployment.yaml
   ```
3. Verify that the deployment is running:
   ```sh
   kubectl get deploy
   ```
4. Check the running pods and assigned IPs:
   ```sh
   kubectl get pods -o wide
   ```

## Configure Service to Expose Application
To expose the application outside the cluster, create a **Service YAML** file (`service.yaml`).
```yaml
apiVersion: v1
kind: Service
metadata:
  name: webapp-service
spec:
  selector:
    app: webapp
  type: NodePort
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8000
      nodePort: 30007
```
1. Apply the service file:
   ```sh
   kubectl apply -f service.yaml
   ```
2. Check the service details:
   ```sh
   kubectl get svc
   ```

## Accessing the Application
### Inside the Cluster
1. SSH into Minikube:
   ```sh
   minikube ssh
   ```
2. Access the application using `curl`:
   ```sh
   curl -L <POD_IP>/demo
   ```
   (Replace `<POD_IP>` with the actual pod IP from `kubectl get pods -o wide`.)

### Outside the Cluster
1. Start the **Minikube tunnel** to allow external access:
   ```sh
   minikube tunnel
   ```
2. Get the service URL:
   ```sh
   minikube service webapp-service --url
   ```
3. Access the application from your browser or terminal:
   ```sh
   curl -L http://<SERVICE_URL>:30007/demo
   ```
   (Replace `<SERVICE_URL>` with the actual URL from the previous command.)

## Kubernetes Autoscaling
Autoscaling helps scale pods dynamically based on CPU or memory usage.
1. Enable autoscaling with `kubectl autoscale`:
   ```sh
   kubectl autoscale deployment webapp-deployment --cpu-percent=50 --min=1 --max=5
   ```
2. Check the Horizontal Pod Autoscaler (HPA):
   ```sh
   kubectl get hpa
   ```
3. Generate CPU load to trigger autoscaling:
   ```sh
   kubectl run --rm -it load-generator --image=busybox -- /bin/sh -c "while true; do wget -q -O- http://webapp-service; done"
   ```

## Auto-Healing with ReplicaSets
Kubernetes ensures pod availability through ReplicaSets.
- If a pod fails, Kubernetes automatically replaces it.
- Check the ReplicaSet:
  ```sh
  kubectl get rs
  ```
- Simulate a pod failure and observe the auto-healing process:
  ```sh
  kubectl delete pod <POD_NAME>
  ```
  (Replace `<POD_NAME>` with an actual pod name.)
- Verify that Kubernetes creates a new pod:
  ```sh
  kubectl get pods
  ```

## Troubleshooting
1. **Check Pod Logs**:
   ```sh
   kubectl logs <POD_NAME>
   ```
2. **Check Service Status**:
   ```sh
   kubectl get svc
   ```
3. **Check Firewall Rules (For Cloud Instances)**:
   - Ensure security group rules allow traffic on **NodePort (30007)**.
   - Verify with:
     ```sh
     sudo iptables -t nat -L -n -v | grep 30007
     ```
4. **Restart Kubernetes Components**:
   ```sh
   sudo systemctl restart docker kubelet
   ```
5. **Debug Issues in a Running Pod**:
   ```sh
   kubectl exec -it <POD_NAME> -- /bin/sh
   ```


