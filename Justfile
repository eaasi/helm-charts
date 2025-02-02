config_dir := "./configs"

### HELPERS ###################################################################

# Run spell checker
spellcheck:
  typos --config "{{ config_dir }}/typos.toml"
