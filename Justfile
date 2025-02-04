# Run spell checker
spellcheck:
  hunspell README.md

# Run typo checker
typocheck:
  typos --config ./configs/typos.toml

# Run chart linter
lint chart="*":
  helm lint ./charts/{{ chart }}

# Run chart validator
validate chart="*":
  docker run -t --rm --network host \
    --workdir=/data \
    --volume $(pwd):/data \
    quay.io/helmpack/chart-testing:v3.7.1 \
    ct lint --config ./configs/chart-testing.yaml \
      {{ if chart == "*" { "--all" } else { "--charts ./charts/" + chart} }}

# Update chart's changelog
update-changelog chart:
  #!/usr/bin/env sh
  set -eu
  cd "./charts/{{ chart }}"
  git cliff --bump --unreleased \
    --tag-pattern "{{ chart }}-.+" \
    --prepend "CHANGELOG.md"
