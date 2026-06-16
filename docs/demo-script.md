# OwlGate — 5-minute demo script

Target: the AgentHack submission video (max 5:00). Show the solution **running**,
the architecture, the agents, and where the human fits.

| Time | Beat | What's on screen |
| :--- | :--- | :--- |
| 0:00–0:30 | **Hook** | "Tests passing ≠ safe to ship." Introduce OwlGate as a release-gate. One-line architecture diagram. |
| 0:30–1:15 | **The change** | Open a PR on `owlgate-sample-app` that touches the contact form. A queue item appears in Orchestrator; the trigger fires. |
| 1:15–2:15 | **Select + execute** | Risk agent output: "3 of 12 suites impacted, risk 0.62." Test Cloud runs *only* those suites. One UI test fails on a changed selector. |
| 2:15–3:15 | **Self-heal** | Self-Healing agent diagnoses the selector change, proposes a fix (coding agent), re-runs in Test Cloud → green. Show the diff it authored. |
| 3:15–4:00 | **Decide** | Gate agent emits **go / no-go** with a written rationale citing the heal + residual risk. |
| 4:00–4:40 | **Human gate** | Action Center task: approver reviews the verdict and **approves** (or overrides). Verdict publishes to `owlgate-dashboard`. |
| 4:40–5:00 | **Coding-agent bonus** | Call out: Claude Code (via UiPath for Coding Agents) scaffolded the solution *and* powers the heal step — coding agents + low-code, combined. |

## Pre-demo checklist

- [ ] `uip login` valid; `uip or licenses info` shows free Test Automation + App Test slots.
- [ ] Sample app deployed and reachable by Test Cloud.
- [ ] Queue `owlgate-changes` + trigger live in `Shared`.
- [ ] The seeded fragility is present (see `owlgate-sample-app` FRAGILITY.md).
- [ ] Dashboard open on the verdict view.
