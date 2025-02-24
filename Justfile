chart_dir := "./charts"
config_dir := "./configs"

# Name of the Minikube cluster
cluster := "eaasi"

# Name of the cluster namespace
namespace := "eaasi"

# External chart repositories
cnpg_chart_repo_url := "https://cloudnative-pg.github.io/charts"

### HELPERS ###################################################################

# Run spell checker
spellcheck:
  hunspell README.md

# Run typo checker
typocheck:
  typos --config "{{ config_dir }}/typos.toml"

# Run chart linter
lint chart="*":
  helm lint {{ chart_dir / chart }}

# Run chart validator
validate chart="*":
  docker run -t --rm --network="host" \
    --workdir="/data" \
    --volume="$PWD:/data" \
    "quay.io/helmpack/chart-testing:v3.7.1" \
    ct lint --config "{{ config_dir }}/chart-testing.yaml" \
      --chart-repos "cnpg={{ cnpg_chart_repo_url }}" \
      {{ if chart == "*" { "--all" } else { '--charts "' + (chart_dir / chart) + '"' } }}

# Update chart's changelog
update-changelog chart:
  #!/usr/bin/env sh
  set -eu
  cd "{{ chart_dir / chart }}"
  git cliff --bump --unreleased \
    --tag-pattern "{{ chart }}-.+" \
    --prepend "CHANGELOG.md"

### HELM ######################################################################

# Add required chart repositories
add-chart-repos:
  helm repo add cnpg "{{ cnpg_chart_repo_url }}"

# Install a Helm chart
install chart name=chart ns=namespace *args="":
  helm install "{{ name }}" "{{ chart_dir / chart }}" \
    --namespace "{{ ns }}" --create-namespace {{ args }}

# Uninstall a Helm chart release
uninstall release ns=namespace *args="":
  helm uninstall "{{ release }}" --namespace "{{ ns }}" {{ args }}

# Upgrade a Helm chart release
upgrade chart release=chart ns=namespace *args="":
  helm upgrade "{{ release }}" "{{ chart_dir / chart }}" \
    --install --namespace "{{ ns }}" --create-namespace {{ args }}

# Render a Helm chart
render chart name=chart ns=namespace *args="":
  helm template "{{ name }}" "{{ chart_dir / chart }}" \
    --namespace "{{ ns }}" {{ args }} | less

### MINIKUBE ##################################################################

# Boot a Minikube cluster
cluster-boot name=cluster ns=namespace *args="":
  minikube start --profile "{{ name }}" \
    --namespace "{{ ns }}" \
    --cni "cilium" \
    --cpus "no-limit" \
    --memory "no-limit" \
    --force-systemd=true \
    --wait=true \
    {{ args }}

# Start a Minikube cluster
cluster-start name=cluster ns=namespace *args="": (cluster-boot name ns args)
  cilium status --wait --ignore-warnings

# Stop a Minikube cluster
cluster-stop name=cluster:
  minikube stop --profile "{{ name }}"

# Pause a Minikube cluster
cluster-pause name=cluster:
  minikube pause --profile "{{ name }}" --all-namespaces

# Unpause a Minikube cluster
cluster-unpause name=cluster:
  minikube unpause --profile "{{ name }}" --all-namespaces

# Delete a Minikube cluster
cluster-delete name=cluster:
  minikube delete --profile "{{ name }}"
