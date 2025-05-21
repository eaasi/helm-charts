// SPDX-FileCopyrightText: 2025 Yale University
// SPDX-License-Identifier: Apache-2.0

// Configuration for a Kubernetes Gateway

package gateway

fullnameOverride: *"" | string

name: *"" | string

className!: string

annotations: *{} | {[string]: string}

labels: *{} | {[string]: string}

listeners: [...{
	name!:    string
	protocol: *"HTTP" | "HTTPS" | "TCP" | "UDP" | "TLS"
	port:     *80 | int
	hostname: *"example.com" | string
	allowedRoutes: {
		namespaces: {
			from: *"Same" | "All" | "Selector" | "None"
		}
	}
}]
