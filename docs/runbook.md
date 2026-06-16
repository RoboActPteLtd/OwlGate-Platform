# OwlGate — Runbook

## Tenant capacity (verified 2026-06-17, UiPath Labs tenant)

`uip or licenses info` — plan **ENTERPRISE**, not expired:

| License | Allowed | Used | OwlGate use |
| :--- | :--- | :--- | :--- |
| TestAutomation | 2 | 0 | Test Cloud execution ✅ |
| AppTest | 2 | 0 | App / UI testing ✅ |
| Unattended | 2 | 0 | RPA glue ✅ |
| AgentService | 0 | 0 | Agents run on **AI units** (consumption), not this counter |
| Flow / ProcessOrchestration | 0 | 0 | Not needed (Track 3 uses Orchestrator, not Maestro) |

Runtime: serverless slots free on the workspace machine (2 Unattended +
2 TestAutomation). **Confirm AI-unit balance in the Automation Cloud portal**
(Tenant → Licenses → AI units) before the demo.

## Provisioned resources

- **Coded agent** `owlgate-gate` (0.0.2) — published to the tenant feed and bound as
  a **process in the `Shared` folder** (env `OWLGATE_ESCALATE=1`). Verified by a
  successful Orchestrator job (verdict `no-go`, `needs_human`).
- **API trigger** `owlgate-on-change` (POST) → the `owlgate-gate` process. A CI/PR
  webhook posts the change to invoke the gate.
- **Queue** `owlgate-changes` — live in `Shared` (unique-reference, max-retries 1)
  as the change-record store.
- **Action Center** — the agent raises an approval task on `needs_human` (SDK
  `sdk.tasks.create`, gated by `OWLGATE_ESCALATE`).

> **Coded agents can't be queue-trigger targets** (HTTP 400 "Process cannot be
> configured for Queue triggers") — they're invoked via agent jobs / API. OwlGate
> therefore uses an **API trigger**, which also fits the "CI webhook posts the diff"
> model better than queue consumption.

### Still requires the UiPath UI / admin

- **Test Cloud / Test Manager** — no Test Manager project is provisioned on the
  tenant ("no projects accessible"). Enabling the Test Manager service and authoring
  the test cases is a portal/Studio step; the agents + sample app prove the testing
  logic in the meantime.

## Common commands

```bash
uip login                         # authenticate
uip or licenses info              # capacity
uip or processes list             # what's deployed
uip or jobs ...                   # monitor a gate run
uip solution pack && uip solution publish
```

## Recovery

- **Stuck queue item** — check `inProgressMaxNumberOfMinutes`; reset the item.
- **Heal loop** — the Self-Healing agent retries a bounded number of times, then
  hands off to the human gate with `status: needs-human`.
