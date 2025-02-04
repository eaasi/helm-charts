chart_dir := "./charts"
config_dir := "./configs"

### HELPERS ###################################################################

# Run spell checker
spellcheck:
  hunspell README.md

# Run typo checker
typocheck:
  typos --config "{{ config_dir }}/typos.toml"

# Update chart's changelog
update-changelog chart:
  #!/usr/bin/env sh
  set -eu
  cd "{{ chart_dir / chart }}"
  git cliff --bump --unreleased \
    --tag-pattern "{{ chart }}-.+" \
    --prepend "CHANGELOG.md"
