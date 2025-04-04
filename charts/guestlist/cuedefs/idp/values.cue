// SPDX-FileCopyrightText: 2025 Yale University
// SPDX-License-Identifier: Apache-2.0

// Configuration for the "@ory/kratos" subchart:
// https://github.com/ory/k8s/tree/master/helm/charts/kratos

package idp

// Should the IDP be enabled?
enabled: bool | *true

// Number of replicas
replicaCount: int | *1

// Version of Ory Kratos
image: {
	tag: string | *"v1.3.1"
}

// Override chart name
nameOverride: "guestlist-idp"

// Override resource name prefix
fullnameOverride: string | *"idp"

// Disable ingresses, which will be replaced
// with equivalent Gateway API definitions!
ingress: {
	admin: enabled: false
	public: enabled: false
}
