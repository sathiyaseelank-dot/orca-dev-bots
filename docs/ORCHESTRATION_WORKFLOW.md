# ORCA Dev Bots — Sprint & Phase Orchestration Workflow

This document defines the controlled, sequential execution workflow for converting a high-level product idea into runnable feature sprints and small implementation phases.

---

## 1. Phase Lifecycle State Machine

Every phase file (`docs/phases/SPRINT-XX/PHASE-XX.md`) tracks an explicit lifecycle status:

```text
PENDING ──▶ READY ──▶ IN_PROGRESS ──▶ REVIEW ──▶ PASS
                          │             │
                          ▼             ▼
                       BLOCKED        FAILED
```

- **`PENDING`**: Phase exists, but upstream dependencies are not yet `PASS`.
- **`READY`**: All dependencies are `PASS`; eligible for dispatch by `sprint-orchestrator-bot`.
- **`IN_PROGRESS`**: Currently dispatched to `ui-research-bot`, `dev-bot`, or `ui-bot`. (Only ONE phase per sprint/worktree is `IN_PROGRESS` at a time.)
- **`REVIEW`**: Implementation complete; undergoing `ui-review-bot` (for UI phases) and/or `qa-bot` phase verification.
- **`PASS`**: All phase acceptance criteria and verification commands passed with evidence.
- **`FAILED` / `BLOCKED`**: Execution stopped; error logs, failing checks, or missing prerequisites recorded explicitly. Orchestrator never skips a failed or blocked phase.

---

## 2. Routing Rules: Backend-Only vs. UI Phases

`sprint-orchestrator-bot` inspects `Phase Type` and `Requires UI Research` before dispatching:

1. **Backend / Database Phases (`DATABASE`, `BACKEND`, `Requires UI Research: false`)**:
   - `sprint-orchestrator-bot` $\rightarrow$ `dev-bot` (executes single phase) $\rightarrow$ `qa-bot` (phase verification) $\rightarrow$ `PASS`.
   - `ui-research-bot`, `ui-bot`, and `ui-review-bot` are **not invoked**.

2. **UI Phases (`UI_RESEARCH`, `UI_IMPLEMENTATION`, `Requires UI Research: true`)**:
   - **Step A (Before Coding)**: `sprint-orchestrator-bot` dispatches to **`ui-research-bot`** to analyze benchmarks via Orca browser, inspect existing project tokens/components, and write `docs/ui-specs/PHASE-XX-UI-SPEC.md`.
   - **Step B (Implementation)**: `sprint-orchestrator-bot` dispatches the UI phase + approved UI spec to **`dev-bot`** (for state/API wiring) and **`ui-bot`** (for production-ready component implementation).
   - **Step C (Visual Gate)**: **`ui-review-bot`** inspects rendered screenshots across desktop/tablet/mobile against the UI spec and grants visual sign-off (or returns exact corrections).
   - **Step D (Phase QA)**: **`qa-bot`** verifies functional & regression tests and reports `PASS` to `sprint-orchestrator-bot`.

3. **Sprint Completion Gate**:
   - When all phases in `SPRINT-XX` reach `PASS`, `sprint-orchestrator-bot` triggers **`qa-bot`** for **Sprint-Level End-to-End Verification** (`SAC-XX`).
   - Only after sprint-level QA passes does `sprint-orchestrator-bot` mark `SPRINT-XX` as `COMPLETED` and hand off to **`secops-bot`**.

---

## 3. Example: One Runnable Sprint Broken Into Small Phases

**Sprint**: `SPRINT-01 — Donor Registration & Searchable Directory`  
**Expected Runnable Result**: A user can open `/donors`, register a new donor, see it saved in the database, and search/filter the donor table.

| Phase ID | Type | Objective (One Cohesive Task) | Assigned Bots | Dependency |
| :--- | :--- | :--- | :--- | :--- |
| **`PHASE-01`** | `DATABASE` | Create `donors` table schema & migration with blood group and cooldown fields. | `dev-bot` $\rightarrow$ `qa-bot` | `None` |
| **`PHASE-02`** | `BACKEND` | Implement `POST /api/donors` and `GET /api/donors` endpoints with validation and unit tests. | `dev-bot` $\rightarrow$ `qa-bot` | `PHASE-01` |
| **`PHASE-03`** | `UI_RESEARCH` | Benchmark donor/directory tables & registration modals via Orca browser; produce `docs/ui-specs/PHASE-04-UI-SPEC.md`. | `ui-research-bot` | `PHASE-02` |
| **`PHASE-04`** | `UI_IMPLEMENTATION` | Build `DonorDirectory`, `DonorTable`, `RegisterDonorModal` with skeletons, empty/error states, and API wiring per UI spec. | `dev-bot` + `ui-bot` $\rightarrow$ `ui-review-bot` $\rightarrow$ `qa-bot` | `PHASE-03` |
| **`PHASE-05`** | `INTEGRATION` | Run end-to-end browser verification of donor registration and filtering against `SAC-01`–`SAC-03`. | `qa-bot` $\rightarrow$ `secops-bot` | `PHASE-04` |
