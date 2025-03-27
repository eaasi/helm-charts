# SPDX-FileCopyrightText: 2025 Yale University
# SPDX-License-Identifier: Apache-2.0

# Directory with CUE definitions
cuedir := "./cuedefs"

# Main CUE file for generating values.yaml
entrypoint := cuedir / "values.cue"

# Compile chart's configuration file
config-compile cuefile=entrypoint outfile="values.yaml":
  cd "{{ cuedir }}" && just compile "{{ absolute_path(cuefile) }}" > "{{ absolute_path(outfile) }}"
