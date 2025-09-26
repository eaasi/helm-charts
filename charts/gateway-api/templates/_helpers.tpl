# SPDX-FileCopyrightText: 2025 Yale University
# SPDX-License-Identifier: Apache-2.0

{{/* Read the content of a downloaded bundle. */}}
{{- define "gwapi.bundle" -}}
{{ .Files.Get (printf "bundles/%s.yaml" .Values.release.channel) }}
{{- end -}}
