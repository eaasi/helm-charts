# Changelog

## database-0.5.0 - *2025-03-21*

### Features

- Add initial database-operator config - ([`0d4dd0b`](https://github.com/eaasi/helm-charts/commit/0d4dd0bcccf8e8010ed9065b0171dfd3732dca40) by @O7EG)
- Add initial database-cluster config - ([`369788b`](https://github.com/eaasi/helm-charts/commit/369788bf7026f57c2d3f00109bdcc9e9658ec599) by @O7EG)
- Configure cluster's pod affinity - ([`4367aa9`](https://github.com/eaasi/helm-charts/commit/4367aa97ac264deeb2821ecfb949943c7f93e0f1) by @O7EG)
- Add connection pooler for the primary instance - ([`cba5cb0`](https://github.com/eaasi/helm-charts/commit/cba5cb0a3b845f14e3de7a3581c96725a9162f0e) by @O7EG)

### Testing

- Add ping-test for configured connection poolers - ([`cad386f`](https://github.com/eaasi/helm-charts/commit/cad386fb82be42d34ef2f8bc37c77576a5f43b25) by @O7EG)

### Continuous Integration

- Add helper for deploying database-operators - ([`004748b`](https://github.com/eaasi/helm-charts/commit/004748bc1b11efed3b8f57c94debd48e1ac54d54) by @O7EG)
- Add helper for deploying database-clusters - ([`9c57108`](https://github.com/eaasi/helm-charts/commit/9c5710818b52528891b926134cb91d9d61736b26) by @O7EG)

### Documentation

- Add initial README - ([`0276d03`](https://github.com/eaasi/helm-charts/commit/0276d037e81a5af708a45d5945b8e1d777929249) by @O7EG)
- Describe a basic deployment procedure - ([`0927d89`](https://github.com/eaasi/helm-charts/commit/0927d89bc35afbd89f5f507311fd4bf4335e5668) by @O7EG)
- Describe available configuration parameters - ([`0e02703`](https://github.com/eaasi/helm-charts/commit/0e02703f223ec294b1bb2a90b7d06e0a870ede4d) by @O7EG)
- Describe how a development database can be deployed - ([`6cce9d2`](https://github.com/eaasi/helm-charts/commit/6cce9d2bc58a4344792b56e3d58fa1a5f622f463) by @O7EG)

### Miscellaneous

- Add initial `.helmignore` - ([`d7477d2`](https://github.com/eaasi/helm-charts/commit/d7477d260d46c770985df3e58d73728e6ad432ef) by @O7EG)
- Add initial chart metadata - ([`68c760f`](https://github.com/eaasi/helm-charts/commit/68c760fdbffd8043eb73183fc2991436474f64dc) by @O7EG)
- Add external chart repository `cnpg` - ([`e3a4591`](https://github.com/eaasi/helm-charts/commit/e3a45914489e1c394a2a2a2c1b332e49a768359a) by @O7EG)
- Add dependency `@cnpg/cloudnative-pg` v0.23.2 - ([`17b1cf9`](https://github.com/eaasi/helm-charts/commit/17b1cf93bd33c5a619198d599642be4521845fa7) by @O7EG)
- Add dependency `@cnpg/cluster` v0.2.1 - ([`7aa67a8`](https://github.com/eaasi/helm-charts/commit/7aa67a8f37cd0d306eaad3697792404600815c83) by @O7EG)
- Fail early when operator and cluster are enabled - ([`2bbde88`](https://github.com/eaasi/helm-charts/commit/2bbde881502ba5c025528e5b338461e8ad442f43) by @O7EG)
- Bump chart version to 0.5.0 - ([`5f692ed`](https://github.com/eaasi/helm-charts/commit/5f692ed519a36baf10981a03d635157202acbc41) by @O7EG)
