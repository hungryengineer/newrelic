# newrelic
This repo contains a step by step detailed process on how to instrument new relic with a python sample containerized app.

# Flask Application Observability with New Relic on Kubernetes

This guide walks through the end-to-end setup of a Python Flask app with New Relic observability (APM, logs, metrics, and traces) using Kubernetes and the New Relic Kubernetes integration.

---

## 🚀 Overview

This setup covers:
- Dockerizing a Flask app
- Pushing the image to Docker Hub
- Deploying it to a Kubernetes cluster
- Integrating New Relic via auto-instrumentation
- Verifying logs, traces, and metrics in New Relic UI

---

## 🧰 Prerequisites

- Docker & Docker Hub account
- A Kubernetes cluster (e.g., EKS, GKE, Minikube)
- kubectl configured with your cluster
- Helm 3.x installed
- A valid New Relic license key (APM-enabled)

---

## 🗂 Directory Structure

.
├── app.py
├── dockerfile
├── newrelic.ini (optional if manual instrumentation)
├── manifest.yaml
├── instrumentation.yaml
└── bootstrap.sh
|__ nr_integration_values.yaml