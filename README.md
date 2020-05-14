# stratus-helm

[Stratus](https://github.com/planetlabs/stratus) is a cloud-enabled repackaging of [GeoServer](http://geoserver.org/) and should be 100% compatable with GeoServer. Stratus is currently based on GeoServer 2.16.0.

This is a set of deployment scripts for building and deploying [Stratus](https://github.com/planetlabs/stratus).
The current goal of this project is to get Stratus accepted into the Google Cloud Marketplace, and untimately ease the transition of GeoServer into the cloud. Despite the GCP focus of the documentation, this should be easily adaptable to any cloud (or k8s) provider.

## Requirements

  - Ingress Controller (Already included in GKE)
  - Redis (or GCP Memorystore)

### Local install (kind)
Both GKE Ingress and Nginx Ingress are supported. If installing outside of GKE, make sure you install Nginx ingress. For example in [kind](https://kind.sigs.k8s.io/docs/user/ingress/) you would do:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
```
  
To install redis in your cluster (rather than using Memorystore), bitnami provides a helm chart.

For testing, the following works, but see [bitnami/redis docs](https://github.com/bitnami/charts/tree/master/bitnami/redis) for tips on production deployment.
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install redis bitnami/redis
export REDIS_PASSWORD=$(kubectl get secret --namespace default redis -o jsonpath="{.data.redis-password}" | base64 --decode)
```

## Install
```
cd stratus
cp sample-values.yaml values.yaml
# edit values.yaml
helm install -f values.yaml stratus .
```
