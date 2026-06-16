# OwlGate — Integration

How the four repos connect into one governed flow on UiPath Automation Cloud.

## Data flow

```
 change (PR/diff)
   │  enqueued as a work item
   ▼
 owlgate-changes (queue) ──trigger──> owlgate-gate (process)
   │
   │  the process invokes the coded agents (owlgate-agents) as its brain:
   │
   ├─ RiskAgent     reads the diff + tests/ catalogue  → selected suites + score
   ├─ Test Cloud    runs the selected suites against owlgate-sample-app
   ├─ HealingAgent  repairs non-functional failures; escalates real ones
   ├─ GateAgent     → go / no-go verdict (+ needs_human)
   │
   ├─ if needs_human → Action Center task ("OwlGate release approval")
   └─ publish-verdict (API Workflow) → owlgate-dashboard (report.json)
```

## Contracts

- **Diff → RiskAgent**: `{ diff: [{path, lines}], catalogue }`. The catalogue lives
  in [`owlgate-agents/catalogues/sample-app.json`](../../owlgate-agents/catalogues/sample-app.json)
  and mirrors [`tests/`](../tests).
- **Pipeline report**: the JSON emitted by `python -m owlgate_agents` — `{ risk,
  results, healed, escalated, verdict }`. This is exactly what the dashboard's
  `report.ts` type consumes and what `publish-verdict` pushes.
- **Human gate**: an Action Center task is created when `verdict.needs_human` is
  true; approve / override / reject is recorded against the change.

## Where each repo fits

| Repo | Role in the flow |
| :--- | :--- |
| `owlgate-agents` | The process "brain" — coded agents + the pipeline CLI. |
| `owlgate-sample-app` | The System Under Test that Test Cloud exercises. |
| `owlgate-platform` | This repo — queue, trigger, process, API Workflows, the gate. |
| `owlgate-dashboard` | Renders the published verdict report. |

## Provisioning

See [`scripts/provision.sh`](../scripts/provision.sh) and
[`orchestration/owlgate.orchestration.json`](../orchestration/owlgate.orchestration.json).
