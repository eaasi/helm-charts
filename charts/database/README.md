# EAASI Database Helm Chart

This Helm chart deploys the EAASI Database on [Kubernetes](https://kubernetes.io/) using the [Helm](https://helm.sh) package manager.

## Getting Started

This chart depends on the [operator](https://github.com/cloudnative-pg/charts/tree/main/charts/cloudnative-pg) and the [cluster](https://github.com/cloudnative-pg/charts/tree/main/charts/cluster) charts from the [CloudNativePG](https://github.com/cloudnative-pg) project.

### Adding the Repositories

```console
$ helm repo add cnpg "https://cloudnative-pg.github.io/charts"
$ helm repo add eaasi "https://eaasi.github.io/helm-charts"
```

### Installing the Operator

First, the *CNPG operator* must be installed, since it provides several CRDs required for setting up new database *clusters*.
Skip this step if the operator is already installed in your K8s cluster:

```console
$ helm install database-operator eaasi/database \
    --namespace cnpg-system --create-namespace \
    -f ./configs/operator.yaml
```

### Creating a Cluster

A new *CNPG cluster* can be created with the following command:

```console
$ helm install database-cluster eaasi/database \
    --namespace database --create-namespace
```

## Configuration

A minimal configuration for an operator and a cluster is provided in the default [values.yaml](./values.yaml) file.
For further details on all available parameters, please refer to the configuration files of the upstream [operator](https://github.com/cloudnative-pg/charts/tree/main/charts/cloudnative-pg) and [cluster](https://github.com/cloudnative-pg/charts/tree/main/charts/cluster) charts.

The extensive documentation for the CloudNativePG project can be found [here](https://cloudnative-pg.io/documentation/current/).
