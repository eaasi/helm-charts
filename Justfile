chart_dir := "./charts"
config_dir := "./configs"

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
