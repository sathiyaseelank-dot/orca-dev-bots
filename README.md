# Orca Autonomous Fullstack Development Bots

A reusable multi-agent software engineering team for the Orca IDE (Stably) that converts product ideas into runnable feature sprints, decomposes sprints into small sequential phases, performs UI research *before* UI implementation, and verifies every step.

## The Team (10 Specialized Bots)

| Bot | Handle | Active Directory | Role |
| :--- | :--- | :--- | :--- |
| **Product Lead** | `bot:product-bot` | `product-bot/` | High-level product requirements, user journeys, constraints, and product-level ACs (`docs/PRD.md`). |
| **Sprint Planner** | `bot:sprint-planner-bot` | `sprint-planner-bot/` | Converts `docs/PRD.md` into cohesive, runnable feature sprints (`docs/sprints/SPRINT-XX.md`). |
| **Phase Decomposer** | `bot:phase-decomposer-bot` | `phase-decomposer-bot/` | Breaks each sprint into small, single-objective sequential phase files (`docs/phases/SPRINT-XX/PHASE-XX.md`). |
| **Sprint Orchestrator** | `bot:sprint-orchestrator-bot` | `sprint-orchestrator-bot/` | Tracks sprint/phase lifecycle (`PENDING → READY → IN_PROGRESS → REVIEW → PASS`), dispatches one phase at a time, stops on failures. |
| **Phase Executor (Dev)** | `bot:dev-bot` | `dev-bot/` | Executes one assigned phase at a time in an isolated worktree; never implements future phases. |
| **UI Research & Design** | `bot:ui-research-bot` | `ui-research-bot/` | Works *before* UI implementation: benchmarks similar websites in Orca browser and writes `docs/ui-specs/PHASE-XX-UI-SPEC.md`. |
| **UI Implementer** | `bot:ui-bot` | `ui-bot-2/` | Implements/refines production UI components from the approved UI spec, reusing design tokens and preserving logic. |
| **UI Visual Auditor** | `bot:ui-review-bot` | `ui-review-bot-2/` | Independent visual reviewer: inspects screenshots across desktop/tablet/mobile against the UI spec and grants visual sign-off. |
| **QA Verifier** | `bot:qa-bot` | `qa-bot/` | Runs phase-level verification (`PASS`/`FAIL`/`BLOCKED`) and sprint-level end-to-end runnable feature verification. |
| **Security & DevOps** | `bot:secops-bot` | `secops-bot/` | Secret scanning, vulnerability audit, GitHub PR lifecycle, CI monitoring, and deployments. |

> **Note on Active UI Directories**: `ui-bot-2/` and `ui-review-bot-2/` are the active, Orca-registered directories for `bot:ui-bot` and `bot:ui-review-bot`.

## Required Workflow

```text
User's Product Idea
   │
   ▼
Product Bot (docs/PRD.md)
   │
   ▼
Sprint Planning Bot (docs/sprints/SPRINT-XX.md)
   │
   ▼
Phase Decomposition Bot (docs/phases/SPRINT-XX/PHASE-XX.md)
   │
   ▼
Sprint Orchestrator (Dispatches 1 eligible phase at a time)
   │
   ├──[Backend / DB Phase]─────────────────────────────────────┐
   │                                                           ▼
   │                                                        Dev Bot (1 phase)
   │                                                           │
   └──[UI Phase]──▶ UI Research Bot (docs/ui-specs/)           │
                         │                                     │
                         ▼                                     │
                    Dev Bot + UI Bot (Implements UI per spec)  │
                         │                                     │
                         ▼                                     │
                    UI Review Bot (Visual sign-off)            │
                         │                                     │
                         └─────────────────┬───────────────────┘
                                           ▼
                                        QA Bot (Phase PASS/FAIL/BLOCKED)
                                           │
                          (All sprint phases PASS + Sprint E2E QA PASS)
                                           │
                                           ▼
                                      SecOps Bot (Security audit & release)
```

See [docs/ORCHESTRATION_WORKFLOW.md](docs/ORCHESTRATION_WORKFLOW.md) and [templates/](templates/) for full lifecycle rules, routing logic, and document templates.

## Exporting & Importing to Another Machine

Clone this repository into `~/.orca/bots` on any machine with Orca installed:
```bash
git clone <your-repo-url> ~/.orca/bots
```
