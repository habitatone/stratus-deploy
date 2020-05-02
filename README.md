# stratus-helm

[Stratus](https://github.com/planetlabs/stratus) is a cloud-enabled repackaging of [GeoServer](http://geoserver.org/) and should be 100% compatable with GeoServer. Stratus is currently based on GeoServer 2.16.0.

This is a set of deployment scripts for building and deploying [Stratus](https://github.com/planetlabs/stratus).
The current goal of this project is to get Stratus accepted into the Google Cloud Marketplace, and untimately ease the transition of GeoServer into the cloud. Despite the GCP focus of the documentation, this should be easily adaptable to any cloud (or k8s) provider.

## Requirements

  - Redis  (GCP Memorystore)
  - PostgreSQL  (GCP Cloud SQL PostreSQL)
  
Currently both of these must be enabled on in your GCP project. Eventually both of these will be built into the deployment.
