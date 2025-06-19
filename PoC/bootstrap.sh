
---

## ✅ `bootstrap.sh` — Automation Script

```bash
#!/bin/bash

# --- Configurable Variables ---
DOCKER_IMAGE="kumaranshuman01/flask-newrelic:latest"
NEW_RELIC_LICENSE_KEY="REPLACE_WITH_YOUR_KEY"
CLUSTER_NAME="eks-monitoring-cluster"
NR_NAMESPACE="newrelic"
APP_NAMESPACE="poc-nr"

# --- Docker Build & Push ---
echo "🔨 Building Docker image..."
docker build -t $DOCKER_IMAGE .

echo "🚀 Pushing Docker image..."
docker push $DOCKER_IMAGE

# --- Install New Relic Bundle via Helm ---
echo "📦 Installing New Relic Helm bundle..."
helm upgrade --install newrelic-bundle newrelic/nri-bundle -f nr_integration_values.yaml \
  --namespace=$NR_NAMESPACE --create-namespace \
  --set global.licenseKey=$NEW_RELIC_LICENSE_KEY \
  --set global.cluster=$CLUSTER_NAME \
  --set newrelic-infrastructure.privileged=true \
  --set ksm.enabled=true \
  --set prometheus.enabled=true \
  --set logging.enabled=true

# --- Apply Instrumentation YAML ---
echo "🧬 Applying Instrumentation CRD..."
kubectl apply -f instrumentation.yaml

# --- Apply App Deployment ---
echo "🚢 Deploying Flask App..."
kubectl create namespace $APP_NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifest.yaml -n $APP_NAMESPACE

echo "✅ Done. Generate traffic using "kubectl port-forward svc/flask-newrelic" to see traces/logs in New Relic!"
