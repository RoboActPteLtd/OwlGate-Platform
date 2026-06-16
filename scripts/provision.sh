#!/usr/bin/env bash
#
# Provision OwlGate's Orchestrator resources on the current UiPath tenant.
# Reads orchestration/owlgate.orchestration.json. Requires an authenticated CLI
# (`uip login`). Flag names may vary by CLI version — check `uip or <cmd> --help`.
#
set -euo pipefail

FOLDER="Shared"

echo "==> Verifying login and capacity"
uip user >/dev/null
uip or licenses info --output table || true

echo "==> Creating queue 'owlgate-changes' in '$FOLDER'"
# 'name' is a positional argument. Safe to skip if it already exists.
uip or queues create owlgate-changes \
  --folder-path "$FOLDER" \
  --description "One work item per change entering the OwlGate gate" \
  --max-retries 1 \
  --enforce-unique-reference \
  || echo "   (queue may already exist — continuing)"

cat <<'NEXT'

Next (after the coded-agent package is published):
  1. From ../owlgate-agents:   uip codedagent pack && uip codedagent publish
  2. Create the gate process bound to the published package:
       uip or processes ...        # see: uip or processes --help
  3. Add the queue trigger that starts the process on a new item:
       uip or triggers ...         # see: uip or triggers --help
  4. Author the API Workflows (fetch-diff, notify, publish-verdict):
       uip api-workflow ...        # see: ../workflows/README.md
NEXT

echo "==> Done."
