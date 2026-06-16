# solution/

The UiPath **Solution** that packages OwlGate for deploy.

Create / manage with the CLI:

```bash
uip solution new owlgate
uip solution pack
uip solution publish
```

A Solution bundles the Test Cloud projects, API Workflows, Orchestrator
processes, and the coded-agent packages so the whole release-gate ships and
versions as one unit. Keep the generated `solution.json` (or equivalent) under
this directory.
