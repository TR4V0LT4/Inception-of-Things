# Inception-of-Things

This project is a **System Administration exercise** designed to introduce Kubernetes through **K3s** and **K3d** using **Vagrant** and **Argo CD**.  
You will learn how to:
- Set up virtual machines with **Vagrant**.
- Deploy and manage applications with **K3s**.
- Use **Ingress** to expose applications.
- Manage continuous delivery pipelines with **Argo CD** and **K3d**.

---

## 📂 Project Structure
```
.
├── p1
│ ├── Vagrantfile
│ ├── scripts/
│ └── confs/
├── p2
│ ├── Vagrantfile
│ ├── scripts/
│ └── confs/
├── p3
│ ├── scripts/
│ └── confs/
```

- **p1** → K3s with Vagrant (2 VMs: Server + Worker)  
- **p2** → K3s with 3 simple applications + Ingress  
- **p3** → K3d with Argo CD and GitHub integration  

---

## ⚙️ Part 1: K3s and Vagrant
- Create **2 virtual machines** using Vagrant:
  - `loginS` → Server (Controller node) → IP: `192.168.56.110`
  - `loginSW` → Worker node → IP: `192.168.56.111`
- Specifications:
  - OS: latest stable distribution of your choice
  - Resources: `1 CPU`, `512MB–1024MB RAM`
- Install **K3s**:
  - On Server: Controller mode
  - On Worker: Agent mode (join using node token)
- Install **kubectl** for cluster management
- Configure **passwordless SSH** between VMs

✅ Expected result:  
Both machines running with dedicated IPs on **eth1**, connected via K3s cluster.

---

## ⚙️ Part 2: K3s and Three Simple Applications
- Use **1 VM** with K3s in **server mode** (`loginS`, IP: `192.168.56.110`).
- Deploy **3 web applications** of your choice.
- Configure **Ingress** to route requests:
  - `Host: app1.com` → Application 1
  - `Host: app2.com` → Application 2 (with 3 replicas)
  - Default (other hosts) → Application 3
- Use **ConfigMaps** if necessary for serving HTML pages.

✅ Expected result:  
Access apps by adding hostnames (`app1.com`, `app2.com`, etc.) in your local `/etc/hosts`.

---

## ⚙️ Part 3: K3d and Argo CD
- Install **K3d** (K3s inside Docker).
- Install **Argo CD** in a dedicated namespace (`argocd`).
- Create another namespace `dev`:
  - Deploy your app automatically using **Argo CD** from your **GitHub repo**.
- Requirements:
  - Application must have **two versions** (`v1` and `v2`).
  - Update GitHub repo → Argo CD detects change → Cluster updates app.
- You may use:
  - Wil’s playground app → [`wil42/playground`](https://hub.docker.com/r/wil42/playground)  
  - Or your own app (must be public on DockerHub with tags `v1` and `v2`).

✅ Expected result:  
- `kubectl get ns` → shows `argocd` and `dev`
- Deployments in `dev` automatically synchronized by Argo CD.
