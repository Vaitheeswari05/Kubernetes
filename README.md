# Kubernetes
# Why Use Kubernetes Instead of Docker?

## Understanding the Difference b/w Docker and K8s

Docker is a Container Platform, whereas Kubernetes is a Container Orchestration Platform. While Docker helps in creating and running containers, Kubernetes manages and automates container deployment, scaling, and operations at an advanced level.

In a Docker-only setup, we face limitations such as:
- Single host dependency
- No built-in auto-scaling
- No automatic healing of failed containers
- Lack of enterprise-level support

Kubernetes addresses these limitations, providing a more robust and scalable container management solution.

## Problems with Docker and How Kubernetes Solves Them

1. **Single Host Limitation**
   - **Problem**: When running multiple containers on a single Docker host, storage limitations can arise. Additionally, if too many containers are started, it can lead to resource exhaustion, causing some containers to fail.
   - **Solution**: Kubernetes operates on a Master-Worker node architecture, allowing deployment across multiple nodes (clusters). This ensures load distribution and prevents storage issues, improving stability and scalability.

2. **Lack of Auto-Scaling**
   - **Problem**: Docker does not have a built-in mechanism to handle traffic surges dynamically. It requires manual intervention to scale up or down.
   - **Solution**: Kubernetes includes a Control Manager that uses ReplicaSets to manage scaling automatically based on demand. It ensures that the required number of container instances are running at all times, preventing overload issues.

3. **No Auto-Healing**
   - **Problem**: If a Docker container crashes or fails, it needs to be restarted or recreated manually, leading to downtime and operational inefficiencies.
   - **Solution**: Kubernetes provides self-healing capabilities. If a container fails, Kubernetes automatically restarts it, ensuring high availability without manual intervention.

4. **Lack of Enterprise-Level Support**
   - **Problem**: Docker alone lacks built-in enterprise-grade features such as advanced networking, security, and integration with cloud services.
   - **Solution**: Kubernetes supports enterprise-level deployments by integrating with cloud vendors like AWS, Azure, and Google Cloud. It provides advanced networking, security, monitoring, and automation features tailored for large-scale applications.
  
## Kubernetes Architecture

![Kubernetes Architecture](https://raw.githubusercontent.com/Vaitheeswari05/Kubernetes/refs/heads/master/K8s_architecture.webp)

### Components of Kubernetes Architecture

1. **Master Node**
   - **API Server**: Exposes Kubernetes API. It is the entry point for all administrative tasks.
   - **Scheduler**: Assigns workloads to the nodes.
   - **Controller Manager**: Manages different controllers that regulate the state of the cluster.
   - **etcd**: A key-value store that holds all the cluster data.

2. **Worker Nodes**
   - **Kubelet**: An agent that runs on each node in the cluster. It ensures that containers are running in a Pod.
   - **Kube Proxy**: Maintains network rules on nodes. It allows network communication to your Pods.
   - **Container Runtime**: (e.g., Docker, containerd) Responsible for running containers.

3. **Pods**
   - The smallest deployable units of computing in Kubernetes. A Pod can contain one or more containers.

4. **Replication Controller/ReplicaSet**
   - Ensures that a specified number of pod replicas are running at any given time.

5. **Services**
   - An abstraction that defines a logical set of Pods and a policy by which to access them.

6. **Ingress**
   - Manages external access to the services, typically HTTP.

7. **ConfigMaps and Secrets**
   - ConfigMaps are used to pass configuration data to Pods.
   - Secrets are used to store sensitive information, such as passwords and tokens.

8. **Persistent Volumes**
   - Provides a way for users to request storage for their Pods.

