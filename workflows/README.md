# workflows/

UiPath **API Workflow** definitions (JSON, run by `uip api-workflow run`).

These are the non-agent glue steps in the gate:

| Workflow | Purpose |
| :--- | :--- |
| `fetch-diff` | Pull the changed files for the current change (from the queue item). |
| `notify` | Post run status to chat / email (Integration Service connector). |
| `publish-verdict` | Push the final go / no-go verdict to `owlgate-dashboard`. |

Author with:

```bash
uip api-workflow registry resolve <connector>
uip api-workflow stub <activity>
uip api-workflow run <workflow>.json
```
