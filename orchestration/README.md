# orchestration/

Orchestrator runtime resources that move a change through the gate.

- **Queue** `owlgate-changes` — one item per change (PR / diff). Items flow
  `New → InProgress → Successful/Failed` as the gate runs.
- **Trigger** — a queue trigger kicks the gate process when a change item lands.
- **Process** `owlgate-gate` — the top-level process: select → execute → heal →
  decide → escalate to Action Center.

Provision with the CLI (folder-scoped to `Shared`):

```bash
uip or queues create --name owlgate-changes --folder-path Shared
uip or triggers ...
uip or processes ...
```

> Track 3 deliberately orchestrates with Orchestrator queues + triggers rather
> than Maestro — Maestro (Flow / ProcessOrchestration) is the centrepiece of
> Tracks 1 & 2 and is not required here.
