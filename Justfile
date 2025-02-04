# Run spell checker
spellcheck:
  hunspell README.md

# Run typo checker
typocheck:
  typos --config ./configs/typos.toml

# Update chart's changelog
update-changelog chart:
  #!/usr/bin/env sh
  set -eu
  cd "./charts/{{ chart }}"
  git cliff --bump --unreleased \
    --tag-pattern "{{ chart }}-.+" \
    --prepend "CHANGELOG.md"
