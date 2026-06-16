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

- **Queue** `owlgate-changes` — live in the `Shared` folder (unique-reference
  enforced, max-retries 1). Created via [`scripts/provision.sh`](../scripts/provision.sh).
- **Coded agent** `owlgate-gate` — **published** to the tenant (process 2200361) via
  `uip codedagent deploy` from [`owlgate-agents/uipath-agent`](../../owlgate-agents/uipath-agent).
- Still to wire on the tenant: the queue trigger → `owlgate-gate` process binding,
  the Test Cloud test cases, and the Action Center approval task.

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
