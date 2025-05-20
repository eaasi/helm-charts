// SPDX-FileCopyrightText: 2025 Yale University
// SPDX-License-Identifier: Apache-2.0

// Configuration for the EAASI Common

package common

import (
	Gateway "github.com/eaasi/helm-charts/common/gateway"
)

nameOverride: *"" | string
fullnameOverride: *"" | string

gateway: ingress: Gateway & {
  {
    name: "ingress-gateway",
    className: "",
    listeners: [
      {name: "http"}
    ]
  }
}
