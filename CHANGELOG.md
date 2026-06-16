# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial scaffold of the OwlGate platform repository (UiPath orchestration layer).
- Repository layout for the UiPath Solution, Test Cloud test specs, API Workflows,
  and Orchestrator orchestration.
- Architecture, demo-script, and runbook docs.
- Declarative orchestration manifest (`orchestration/owlgate.orchestration.json`),
  a `scripts/provision.sh` using the `uip` CLI, and an integration guide
  (`docs/integration.md`) wiring the queue → trigger → process → agents → gate →
  dashboard flow. The `owlgate-changes` queue is **provisioned on the UiPath Labs
  tenant** (Shared folder, unique-reference enforced).
- Minimal GitHub Actions CI — required-files check and JSON well-formedness validation; gitleaks secret scan.
- Test Manager content authored via `uip tm` — project `OwlGate` (`OWLGATE`) with
  test set `OwlGate smoke` and 4 test cases.

### Fixed

- Corrected docs that overstated the Action Center HITL as live: the **Actions
  service is not enabled on the tenant**, so the coded `sdk.tasks.create` escalation
  cannot raise a visible task yet (it is implemented and process-configured).

### Changed

- Relicensed from MIT to Apache 2.0.
