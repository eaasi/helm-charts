chart_dir := "./charts"
config_dir := "./configs"

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
      {{ if chart == "*" { "--all" } else { '--charts "' + (chart_dir / chart) + '"' } }}

# Update chart's changelog
update-changelog chart:
  #!/usr/bin/env sh
  set -eu
  cd "{{ chart_dir / chart }}"
  git cliff --bump --unreleased \
    --tag-pattern "{{ chart }}-.+" \
    --prepend "CHANGELOG.md"
