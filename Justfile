chart_dir := "./charts"
config_dir := "./configs"

### HELPERS ###################################################################

# Run spell checker
spellcheck:
  typos --config "{{ config_dir }}/typos.toml"

# Update chart's changelog
update-changelog chart version="" dir=(chart_dir / chart):
  #!/usr/bin/env -S sh -eu -o allexport
  test -f cliff.env && . ./cliff.env
  export cliff_commit_scope="{{ chart }}"
  git cliff --unreleased \
    {{ if version == "" { "--bump" } else { "--tag " + chart + "-" + version } }} \
    --tag-pattern "{{ chart }}-.+" \
    --prepend "{{ dir }}/CHANGELOG.md"
