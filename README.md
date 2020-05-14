# stratus-deploy

This is a set of deployment scripts for building a docker container and deploying [Stratus](https://github.com/planetlabs/stratus).

[Stratus](https://github.com/planetlabs/stratus) is a cloud-native repackaging of [GeoServer](http://geoserver.org/) and should be 100% compatable with GeoServer. Stratus is currently based on GeoServer 2.16.0.

The current goal of this project is to untimately ease the transition of GeoServer into the cloud. We will be targeting Google Cloud and GKE, but some testing is done with [kind](https://kind.sigs.k8s.io/) and it shouldn't take much to get things working on other Kubernetes clusters.

## Requirements

  - Kubernetes
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

Once Redis (or GCP Memorystor) is set up, installing Stratus can be done with helm:

```
cd stratus
cp sample-values.yaml values.yaml
# edit values.yaml
helm install -f values.yaml stratus .
```

## GKE Considerations

3 n1 nodes are recommended. See `make-gke-cluster.sh` for an example.

