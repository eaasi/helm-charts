# EAASI Helm Charts

This repository contains charts for bootstrapping EAASI on [Kubernetes](https://kubernetes.io/)
using the [Helm](https://helm.sh) package manager.

## Helm Repository

Add this Helm repository using:

```console
$ helm repo add eaasi https://eaasi.github.io/helm-charts
$ helm repo update
```

List the available charts by running:

```console
$ helm search repo eaasi
```

## Charts

For more details, see the documentation for each chart:

## Development

Multiple [Just](https://github.com/casey/just) recipes are provided in order to simplify local chart development.
For an overview of all available recipes and their parameters, take a look at the provided [Justfile](./Justfile) or simply run:

```console
$ just --list
```

### Chart Helpers

All source files can be checked for typos with:

```console
$ just typocheck
```

A chart linter can be run against a specific chart or all charts with:

```console
$ just lint <chart>  # omit name to lint all charts!
```

An extended validation can be performed on a specific chart or all charts with:

```console
$ just validate <chart>  # omit name to validate all charts!
```

All chart's templates can be rendered (without installing) with:

```console
$ just render <chart>  # <name> <namespace>
```

A specific chart can be installed or upgraded with:

```console
$ just install <chart>  # <name> <namespace>
$ just upgrade <chart>  # <release> <namespace>
```

A previously installed release can be removed with:

```console
$ just uninstall <release>  # <namespace>
```

### Minikube Management

A local [Minikube](https://minikube.sigs.k8s.io) cluster can be created with:

```console
$ just cluster-start <name>
```

A running Minikube cluster can be paused and resumed later with:

```console
$ just cluster-pause <name>
$ just cluster-unpause <name>
```

When a local Minikube cluster is not needed anymore, it can be stopped or deleted with:

```console
$ just cluster-stop <name>
$ just cluster-delete <name>
```

### Deployment

Before deploying anything, the chart repositories for all dependencies must be added with:

```console
$ just add-chart-repos
```

## License

Helm charts for EAASI are distributed under the [Apache-2.0](./LICENSE) license.

Copyright (c) 2025 Yale University (unless otherwise noted).
