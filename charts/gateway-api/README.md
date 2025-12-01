# Gateway API Helm Chart

This Helm chart installs the [Gateway API](https://gateway-api.sigs.k8s.io/) CRDs on [Kubernetes](https://kubernetes.io/) using the [Helm](https://helm.sh) package manager.

## Getting Started

This chart represents a convenience wrapper around the official Gateway API [bundles](https://github.com/kubernetes-sigs/gateway-api/releases).
For manual installation instructions, see the upstream [documentation](https://gateway-api.sigs.k8s.io/guides/#installing-gateway-api).

> [!WARNING]
> CRDs in Kubernetes are highly privileged cluster-scoped resources.
> Before proceeding, please also read the upstream [guide](https://gateway-api.sigs.k8s.io/guides/crd-management/) for the Gateway API CRD management.

### Adding the Repository

```console
helm repo add eaasi "https://eaasi.github.io/helm-charts"
```

### Installing the Gateway API

The bundled Gateway API CRDs can be installed with the following command:

```console
helm install gateway-api eaasi/gateway-api --namespace kube-system
```
