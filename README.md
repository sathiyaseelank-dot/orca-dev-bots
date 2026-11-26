# Orca Autonomous Fullstack Development Bots

A reusable multi-agent software engineering team for the Orca IDE (Stably) that converts product ideas into runnable feature sprints, decomposes sprints into small sequential phases, performs UI research *before* UI implementation, and verifies every step.

## The Team (10 Specialized Bots)

| Bot | Handle | Active Directory | Role |
| :--- | :--- | :--- | :--- |
| **Product Lead** | `bot:product-bot` | `product-bot/` | High-level product requirements, user journeys, constraints, and product-level ACs (`docs/PRD.md`). |
| **Sprint Planner** | `bot:sprint-planner-bot` | `sprint-planner-bot/` | Converts `docs/PRD.md` into cohesive, runnable feature sprints (`docs/sprints/SPRINT-XX.md`). |
| **Phase Decomposer** | `bot:phase-decomposer-bot` | `phase-decomposer-bot/` | Breaks each sprint into small, single-objective sequential phase files (`docs/phases/SPRINT-XX/PHASE-XX.md`). |
| **Sprint Orchestrator** | `bot:sprint-orchestrator-bot` | `sprint-orchestrator-bot/` | Sole writer of phase status (`PENDING → PASS`), dispatches 1 phase at a time, enforces `MAX_RETRIES=3` & `HOTFIX` fast-path. |
| **Phase Executor (Dev)** | `bot:dev-bot` | `dev-bot/` | Executes `DATABASE`, `BACKEND`, `API_CLIENT`, `INTEGRATION`, and backend `HOTFIX` phases one at a time in isolated worktrees. |
| **UI Research & Design** | `bot:ui-research-bot` | `ui-research-bot/` | Works *before* UI implementation: benchmarks sites in Orca browser, maintains `docs/DESIGN_SYSTEM.md`, writes `docs/ui-specs/PHASE-XX-UI-SPEC.md`. |
| **UI Implementer** | `bot:ui-bot` | `ui-bot-2/` | Owns `UI_IMPLEMENTATION` phases solo from `docs/DESIGN_SYSTEM.md` + approved UI spec, preserving APIs & business logic. |
| **UI Visual Auditor** | `bot:ui-review-bot` | `ui-review-bot-2/` | Independent visual reviewer: inspects screenshots across desktop/tablet/mobile against `docs/DESIGN_SYSTEM.md` & the UI spec. |
| **QA Verifier** | `bot:qa-bot` | `qa-bot/` | Runs phase-level verification (`PASS`/`FAIL`/`BLOCKED`) and sprint-level end-to-end runnable feature verification. |
| **Security & DevOps** | `bot:secops-bot` | `secops-bot/` | Secret scanning, vulnerability audit, GitHub PR lifecycle, CI monitoring, and deployments. |

> **Note on Active UI Directories**: `ui-bot-2/` and `ui-review-bot-2/` are the active, Orca-registered directories for `bot:ui-bot` and `bot:ui-review-bot`.

## Required Workflow

```text
User's Product Idea                         [Small Bugfix / Hotfix Fast-Track]
   │                                                       │
   ▼                                                       │
Product Bot (docs/PRD.md)                                  │
   │                                                       │
   ▼                                                       │
Sprint Planning Bot (docs/sprints/SPRINT-XX.md)            │
   │                                                       │
   ▼                                                       │
Phase Decomposition Bot (docs/phases/SPRINT-XX/PHASE-XX.md)│
   │                                                       │
   ▼                                                       ▼
Sprint Orchestrator (Sole status writer; MAX_RETRIES = 3; 1 phase at a time)
   │
   ├──[Backend / DB / Hotfix Phase]────────────────────────────┐
   │                                                           ▼
   │                                                        Dev Bot (1 phase)
   │                                                           │
   └──[UI Phase]──▶ UI Research Bot (docs/DESIGN_SYSTEM.md     │
                         │           & docs/ui-specs/)         │
                         ▼                                     │
                    UI Bot (Solo UI implementation per spec)   │
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
