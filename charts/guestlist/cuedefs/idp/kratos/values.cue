// SPDX-FileCopyrightText: 2025 Yale University
// SPDX-License-Identifier: Apache-2.0

package kratos

automigration: {
	// Enable database migration
	enabled: bool | *true
	// Always execute migrations as Jobs
	type: "job"
}
