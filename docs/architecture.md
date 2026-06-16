# OwlGate — Architecture

OwlGate is a release-gate: it decides whether a change is safe to ship, using
agents to reason and UiPath to execute and govern.

## Actors

- **Risk agent** — diff → impacted suites + risk score.
- **Self-Healing agent** — broken test → diagnosis → proposed fix → re-run.
- **Gate agent** — all signals → go / no-go verdict + rationale.
- **Human approver** — approves or overrides the verdict at the gate.

## Flow

```
 change (PR/diff)
      │
      ▼
 [queue: owlgate-changes]
      │  trigger
      ▼
 ┌─────────────── owlgate-gate (Orchestrator process) ───────────────┐
 │  1. Risk agent      → select suites + score                        │
 │  2. Test Cloud      → run selected UI + API suites                 │
 │  3. Self-Heal agent → fix non-functional breaks, re-run            │
 │  4. Gate agent      → go / no-go verdict + rationale               │
 │  5. Action Center   → human approves / overrides   (the gate)      │
 │  6. publish-verdict → owlgate-dashboard                            │
 └────────────────────────────────────────────────────────────────────┘
```

## Why this is Track 3 (and not 1 or 2)

The valuable behaviour is **agentic software testing** — deciding what to test,
detecting fragile tests, recommending fixes, and orchestrating the right tests by
risk. UiPath Test Cloud is the execution and governance layer; Orchestrator (not
Maestro) coordinates because the path is a fixed pipeline, not a dynamic case.

## Component diagram

```plantuml
@startuml
skinparam componentStyle rectangle
skinparam shadowing false

actor "Developer" as dev
actor "Approver" as appr

package "OwlGate (UiPath Automation Cloud)" {
  queue "owlgate-changes\n(queue)" as q
  component "owlgate-gate\n(process)" as gate
  component "Test Cloud\n(UI + API suites)" as tc
  component "Risk agent" as risk
  component "Self-Healing agent" as heal
  component "Gate agent" as decide
  component "Action Center\n(HITL gate)" as ac
}

component "owlgate-sample-app\n(System Under Test)" as sut
component "owlgate-dashboard\n(verdict board)" as dash

dev --> q : change lands
q --> gate : trigger
gate --> risk
risk --> tc : selected suites
tc --> sut : exercises
tc --> heal : failures
heal --> tc : re-run
gate --> decide
decide --> ac
appr --> ac : approve / override
ac --> dash : publish verdict
@enduml
```
