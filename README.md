# 🚀 Kubernetes End-to-End Application Observability Stack

**A production-ready Multi-Node Kubernetes Monitoring Architecture featuring a custom Node.js application, Prometheus Operator, Grafana dashboards, and Alertmanager integrations with Slack.**

![Kubernetes Kubeadm](https://img.shields.io/badge/Kubernetes-kubeadm-blue?style=for-the-badge\&logo=kubernetes)
![Node.js](https://img.shields.io/badge/Node.js-v20-green?style=for-the-badge\&logo=node.js)
![Prometheus](https://img.shields.io/badge/Prometheus-Alerting-orange?style=for-the-badge\&logo=prometheus)
![Slack](https://img.shields.io/badge/Slack-Integration-4A154B?style=for-the-badge\&logo=slack)

---

# 📖 Project Overview

This project demonstrates how to build and implement a modern observability framework on a multi-node Kubernetes cluster orchestrated via **kubeadm**.

It showcases the complete monitoring lifecycle, starting from application instrumentation and metrics collection, through automated alert generation, and ending with real-time Slack notifications.

## 🎯 Core Objectives

* **Application Instrumentation**
  Instrumenting a Node.js Express application using Prometheus native client libraries.

* **Declarative Monitoring Resources**
  Implementing Prometheus Operator CRDs including:

  * ServiceMonitor
  * PrometheusRule
  * AlertmanagerConfig

* **Load Testing & Alert Validation**
  Generating concurrent traffic to validate alert thresholds and monitoring pipelines.

* **External Access Design**
  Exposing application services through Kubernetes NodePort networking.

---

# 📐 System Architecture

```text
[ External Traffic / Load Script ]
               │
               ▼ (NodePort: 30005)
      [ Kubernetes Service ]
               │
        ┌──────┴──────┐
        ▼             ▼
 [ Pod: App v1 ] [ Pod: App v2 ] ... (3 Replicas)
        │
        ▼ ( /metrics endpoint )
 [ ServiceMonitor ]
        │
        ▼
 [ Prometheus Engine ]
        │
        ▼
 [ PrometheusRule ]
        │ (Threshold Breach)
        ▼
 [ AlertmanagerConfig ]
        │
        ▼
 [ Slack Webhook ]
        │
        ▼
 [ Slack Channel ]
```

---

# 🏗️ Technology Stack

| Component            | Purpose                    |
| -------------------- | -------------------------- |
| Kubernetes (kubeadm) | Cluster Orchestration      |
| Node.js + Express    | Application Runtime        |
| Prometheus           | Metrics Collection         |
| Prometheus Operator  | Monitoring Automation      |
| Alertmanager         | Alert Routing              |
| Slack Webhooks       | Notification Delivery      |
| Grafana              | Visualization & Dashboards |
| Bash                 | Load Testing Automation    |

---

# 📂 Repository Structure

```text
.
├── Dockerfile
├── index.js
├── nodejs-alert-manager.yaml
├── nodejs-app.yaml
├── nodejs-monitor.yaml
├── nodejs-rule.yaml
├── nodejs-svc.yaml
└── send-request.sh
```

### File Description

| File                      | Description                                         |
| ------------------------- | --------------------------------------------------- |
| Dockerfile                | Lightweight container image build configuration     |
| index.js                  | Application logic and Prometheus metric definitions |
| nodejs-app.yaml           | Kubernetes Deployment (3 replicas)                  |
| nodejs-svc.yaml           | NodePort Service definition                         |
| nodejs-monitor.yaml       | ServiceMonitor for Prometheus Operator              |
| nodejs-rule.yaml          | Prometheus alert rules                              |
| nodejs-alert-manager.yaml | AlertmanagerConfig with Slack integration           |
| send-request.sh           | Automated load generation script                    |

---

# 🚀 Deployment Guide

## 1️⃣ Verify Cluster Connectivity

Ensure kubectl is pointing to the correct cluster.

```bash
export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get nodes
```

Expected Output:

```bash
NAME           STATUS   ROLES           AGE
master-node    Ready    control-plane   xxd
worker-node1   Ready    <none>          xxd
worker-node2   Ready    <none>          xxd
```

---

## 2️⃣ Build & Push Application Image

Build the Docker image:

```bash
docker build -t your-registry-namespace/nodejs-app:v1 .
```

Push it to your registry:

```bash
docker push your-registry-namespace/nodejs-app:v1
```

Update the Deployment manifest with your image before deployment.

---

## 3️⃣ Deploy Application Infrastructure

Deploy the application and service:

```bash
kubectl apply -f nodejs-app.yaml
kubectl apply -f nodejs-svc.yaml
```

Verify deployment:

```bash
kubectl get pods
kubectl get svc
```

---

## 4️⃣ Deploy Monitoring Components

Apply the monitoring resources:

```bash
kubectl apply -f nodejs-monitor.yaml
kubectl apply -f nodejs-rule.yaml
kubectl apply -f nodejs-alert-manager.yaml
```

Verify resources:

```bash
kubectl get servicemonitors
kubectl get prometheusrules
kubectl get alertmanagerconfigs
```

---

# 📊 Metrics Collection Flow

```text
Application
     │
     ▼
prom-client Metrics
     │
     ▼
/metrics Endpoint
     │
     ▼
ServiceMonitor
     │
     ▼
Prometheus
     │
     ▼
PrometheusRule Evaluation
     │
     ▼
Alertmanager
     │
     ▼
Slack Notification
```

---

# 🚨 Alert Testing Strategy

The repository includes a stress-testing script that continuously generates requests against the application.

Grant execution permission:

```bash
chmod +x send-request.sh
```

Run the test:

```bash
./send-request.sh
```

The script launches multiple concurrent request loops to:

* Increase traffic volume
* Trigger alert thresholds
* Validate Prometheus scraping
* Confirm Alertmanager routing
* Verify Slack notification delivery

---

# 🔍 Monitoring Verification

Check application metrics:

```bash
curl http://<NODE-IP>:30005/metrics
```

Verify Prometheus target discovery:

```bash
kubectl port-forward svc/prometheus-operated 9090 -n monitoring
```

Open:

```text
http://localhost:9090
```

Confirm:

* Target is UP
* Metrics are being scraped
* Rules are active
* Alerts transition correctly

---

# 📈 Grafana Visualization

Import dashboards into Grafana to visualize:

* Request Throughput
* Error Rate
* HTTP Response Time
* Pod Resource Consumption
* Alert Status

Suggested panels:

* Requests per Second (RPS)
* CPU Usage
* Memory Usage
* Pod Availability
* Active Alerts

---

# 🔔 Slack Alerting Workflow

```text
Prometheus Rule Triggered
          │
          ▼
      Alertmanager
          │
          ▼
      Slack Webhook
          │
          ▼
     Slack Channel
```

Example use cases:

* High Request Rate
* Application Errors
* Pod Restart Loops
* High CPU Usage
* High Memory Consumption

---

# 🎯 Learning Outcomes

By completing this project I gained hands-on experience with:

* Kubernetes Deployments & Services
* Multi-Node Cluster Operations
* Application Instrumentation
* Prometheus Operator CRDs
* ServiceMonitor Configuration
* Alertmanager Routing
* Slack Integrations
* Load Testing
* Observability Engineering
* Production Monitoring Workflows

---

# 👨‍💻 Author

**Abdelrahim Badr**

DevOps Engineer
