# owlgate-platform

[![CI](https://github.com/RoboActPteLtd/OwlGate-Platform/actions/workflows/ci.yml/badge.svg)](https://github.com/RoboActPteLtd/OwlGate-Platform/actions/workflows/ci.yml)

The UiPath orchestration layer for **OwlGate** — an agentic release-gate built on
**UiPath Test Cloud** for UiPath AgentHack 2026, **Track 3**.

This is the **main repository**. It binds the System Under Test, the coded agents,
and the human approver into one governed flow on UiPath Automation Cloud.

## What it does

OwlGate turns "did the tests pass?" into "**should we ship?**". On each change it:

1. **Selects** — the Risk agent maps the diff to impacted test suites and scores risk.
2. **Executes** — Orchestrator runs only the selected suites in Test Cloud.
3. **Heals** — when a test breaks for non-functional reasons, the Self-Healing agent
   proposes a fix and re-runs it.
4. **Decides** — the Gate agent emits a **go / no-go verdict** with a rationale.
5. **Governs** — a human approves or overrides at an Action Center gate before release.

## UiPath components used

| Component | Use in OwlGate |
| :--- | :--- |
| **Test Cloud** | Executes the selected UI + API test suites against the sample app. |
| **Orchestrator** | Hosts processes, queues (work items per change), and triggers. |
| **API Workflows** | Glue steps — fetch the diff, post results, notify, publish the verdict. |
| **Action Center** | The human-in-the-loop **gate** — approve / override the verdict. |
| **Coded Agents** | Risk, Self-Healing, and Gate agents (see [`owlgate-agents`](../owlgate-agents)). |
| **Solutions** | Packs the whole thing for deploy (`uip solution pack` / `publish`). |

## Repository layout

```
solution/        UiPath Solution definition (uip solution)
tests/           Test Cloud test-case specs (UI + API) for the sample app
workflows/       API Workflow definitions (JSON) — diff fetch, notify, publish
orchestration/   Queue / trigger / process definitions and notes
docs/            Architecture, demo script, runbook
```

## Prerequisites

- A UiPath Automation Cloud tenant with **Test Automation** + **App Test** licenses
  (2 each is enough for the demo) and AI units for the agents.
- `uip` CLI ≥ 1.195 (`uip --version`), authenticated (`uip login`).
- The sibling repos cloned alongside this one (see workspace `README.md`).

## Setup

```bash
# 1. Authenticate
uip login

# 2. Inspect available capacity (optional)
uip or licenses info

# 3. Pack and publish the solution
uip solution pack
uip solution publish
```

See [`docs/demo-script.md`](./docs/demo-script.md) for the 5-minute walkthrough.

## Built with coding agents

OwlGate was **designed and scaffolded with Claude Code** (a coding agent) acting
through *UiPath for Coding Agents*. The Self-Healing agent itself also uses a coding
agent to author test-fix patches. This is a **combination of coding agents and
low-code / UiPath-native components** — see the demo video for where each is used.

## License

[Apache 2.0](./LICENSE)
