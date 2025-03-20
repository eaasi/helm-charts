chart_dir := "./charts"
config_dir := "./configs"

# Name of the Minikube cluster
cluster := "eaasi"

# Name of the cluster namespace
namespace := "eaasi"

### HELPERS ###################################################################

# Run spell checker
spellcheck:
  typos --config "{{ config_dir }}/typos.toml"

# Run chart linter
lint chart="*":
  helm lint "{{ chart_dir / chart }}"

# Run chart validator
validate chart="*":
  docker run -t --rm --network="host" \
    --workdir="/data" \
    --volume="$PWD:/data" \
    --volume="$(helm env HELM_CACHE_HOME):/root/.cache/helm:ro" \
    --volume="$(helm env HELM_CONFIG_HOME):/root/.config/helm:ro" \
    "quay.io/helmpack/chart-testing:v3.7.1" \
    ct lint --config "{{ config_dir }}/chart-testing.yaml" \
      --helm-dependency-extra-args "--skip-refresh" \
      {{ if chart == "*" { "--all" } else { '--charts "' + (chart_dir / chart) + '"' } }}

# Update chart's changelog
update-changelog chart version="" dir=(chart_dir / chart):
  #!/usr/bin/env -S sh -eu -o allexport
  test -f cliff.env && . ./cliff.env
  export cliff_commit_scope="{{ chart }}"
  git cliff --unreleased \
    {{ if version == "" { "--bump" } else { "--tag " + chart + "-" + version } }} \
    --tag-pattern "{{ chart }}-.+" \
    --prepend "{{ dir }}/CHANGELOG.md"

### HELM ######################################################################

# Add external chart repositories
add-chart-repos:
  helm repo add "cnpg" "https://cloudnative-pg.github.io/charts"

# Build dependencies for all charts
build-chart-deps:
  #!/usr/bin/env -S sh -eu
  charts=$(ls "{{ chart_dir }}/")
  for chart in $charts; do
    just dep-build "$chart"
  done

# Build Helm chart's dependencies from its lock file
dep-build chart *args="--skip-refresh":
  helm dependency build "{{ chart_dir / chart }}" {{ args }}

# Update Helm chart's on-disk dependencies
dep-update chart *args="--skip-refresh":
  helm dependency update "{{ chart_dir / chart }}" {{ args }}

# Install a Helm chart
install chart name=chart ns=namespace *args:
  helm install "{{ name }}" "{{ chart_dir / chart }}" \
    --namespace "{{ ns }}" --create-namespace {{ args }}

# Uninstall a Helm chart release
uninstall release ns=namespace *args:
  helm uninstall "{{ release }}" --namespace "{{ ns }}" {{ args }}

# Upgrade a Helm chart release
upgrade chart release=chart ns=namespace *args:
  helm upgrade "{{ release }}" "{{ chart_dir / chart }}" \
    --namespace "{{ ns }}" --create-namespace --install {{ args }}

# Render a Helm chart
render chart name=chart ns=namespace *args:
  helm template "{{ name }}" "{{ chart_dir / chart }}" \
    --namespace "{{ ns }}" {{ args }} | less

### MINIKUBE ##################################################################

# Start a Minikube cluster
cluster-start name=cluster ns=namespace *args:
  minikube start --profile "{{ name }}" \
    --namespace "{{ ns }}" \
    --cpus "no-limit" \
    --memory "no-limit" \
    --force-systemd=true \
    {{ args }}

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

### EAASI #####################################################################

# Deploy the database-operator
deploy-database-operator name="database-operator" ns="cnpg-system" *args="--wait": \
  (upgrade "database" name ns "-f" (chart_dir / "database/configs/operator.yaml") args)
