# ORCA Dev Bots — Sprint & Phase Orchestration Workflow

This document defines the controlled, sequential execution workflow for converting a high-level product idea into runnable feature sprints and small implementation phases.

---

## 1. Phase Lifecycle & Ownership Rules

Every phase file (`docs/phases/SPRINT-XX/PHASE-XX.md`) tracks an explicit lifecycle status:

```text
PENDING ──▶ READY ──▶ IN_PROGRESS ──▶ REVIEW ──▶ PASS
                          │             │
                          ▼             ▼
                       BLOCKED        FAILED (Retry <= 3; at 3 -> BLOCKED + Escalate to Owner)
```

- **Sole Status Writer**: **`sprint-orchestrator-bot`** is the **only** bot that mutates `Completion Status` and `Retry Count` in `PHASE-XX.md` (and Orca items). Worker and reviewer bots report their results via `orca orchestration send/reply`.
- **Max-Retry & Escalation Cap (`MAX_RETRIES = 3`)**: If a phase fails `qa-bot` or `ui-review-bot` **3 times**, `sprint-orchestrator-bot` marks it `BLOCKED`, halts execution, and escalates to the owner with failure logs.
- **Mutually Exclusive Phase Ownership (Option A)**:
  - **`dev-bot`** owns `DATABASE`, `BACKEND`, `API_CLIENT` / state-hook, `INTEGRATION`, and backend `HOTFIX` phases.
  - **`ui-bot`** owns `UI_IMPLEMENTATION` (and UI-only `HOTFIX`) phases **solo**, wiring into the APIs/hooks already built by `dev-bot`.
- **Shared Project Design System (`docs/DESIGN_SYSTEM.md`)**: `ui-research-bot` creates and maintains `docs/DESIGN_SYSTEM.md` inside each target project repository so `ui-bot` and `ui-review-bot` share one design truth across all sprints.

---

## 2. Routing Rules: Backend, UI, and Hotfix Fast-Track

1. **Backend / Database / Integration Phases (`Requires UI Research: false`)**:
   - `sprint-orchestrator-bot` $\rightarrow$ **`dev-bot`** (executes single phase) $\rightarrow$ **`qa-bot`** (phase verification) $\rightarrow$ `PASS`.
   - `ui-research-bot`, `ui-bot`, and `ui-review-bot` are **not invoked**.

2. **UI Phases (`Requires UI Research: true`)**:
   - **Step A (Before Coding)**: `sprint-orchestrator-bot` dispatches to **`ui-research-bot`** to benchmark comparable sites in Orca browser, update `docs/DESIGN_SYSTEM.md`, and write `docs/ui-specs/PHASE-XX-UI-SPEC.md`.
   - **Step B (Solo UI Implementation)**: `sprint-orchestrator-bot` dispatches `UI_IMPLEMENTATION` solo to **`ui-bot`** using `docs/DESIGN_SYSTEM.md` + `docs/ui-specs/PHASE-XX-UI-SPEC.md`.
   - **Step C (Visual Gate)**: **`ui-review-bot`** inspects rendered screenshots across desktop/tablet/mobile against `docs/DESIGN_SYSTEM.md` and the UI spec, reporting `PASS` or exact corrections to `sprint-orchestrator-bot`.
   - **Step D (Phase QA)**: **`qa-bot`** verifies functional & regression tests and reports `PASS` to `sprint-orchestrator-bot`.

3. **Hotfix Fast-Track Path (`HOTFIX`)**:
   - Small, isolated bugfixes enter directly at **`sprint-orchestrator-bot`** as a single `HOTFIX` phase $\rightarrow$ `dev-bot` (or `ui-bot` if UI-only) $\rightarrow$ `qa-bot`, bypassing full PRD and Sprint Planning.

4. **Sprint Completion Gate**:
   - When all phases in `SPRINT-XX` reach `PASS`, `sprint-orchestrator-bot` triggers **`qa-bot`** for **Sprint-Level End-to-End Verification** (`SAC-XX`).
   - Only after sprint-level QA passes does `sprint-orchestrator-bot` mark `SPRINT-XX` as `COMPLETED` and hand off to **`secops-bot`**.

---

## 3. Example: One Runnable Sprint Broken Into Small Phases

**Sprint**: `SPRINT-01 — Donor Registration & Searchable Directory`  
**Expected Runnable Result**: A user can open `/donors`, register a new donor, see it saved in the database, and search/filter the donor table.

| Phase ID | Type | Objective (One Cohesive Task) | Assigned Owner & Gate | Dependency |
| :--- | :--- | :--- | :--- | :--- |
| **`PHASE-01`** | `DATABASE` | Create `donors` table schema & migration with blood group and cooldown fields. | `dev-bot` $\rightarrow$ `qa-bot` | `None` |
| **`PHASE-02`** | `BACKEND` | Implement `POST /api/donors` and `GET /api/donors` endpoints with validation and unit tests. | `dev-bot` $\rightarrow$ `qa-bot` | `PHASE-01` |
| **`PHASE-03`** | `UI_RESEARCH` | Benchmark donor/directory tables & registration modals via Orca browser; update `docs/DESIGN_SYSTEM.md` & produce `docs/ui-specs/PHASE-04-UI-SPEC.md`. | `ui-research-bot` | `PHASE-02` |
| **`PHASE-04`** | `UI_IMPLEMENTATION` | Build `DonorDirectory`, `DonorTable`, `RegisterDonorModal` with skeletons, empty/error states, and API wiring per UI spec. | `ui-bot` $\rightarrow$ `ui-review-bot` $\rightarrow$ `qa-bot` | `PHASE-03` |
| **`PHASE-05`** | `INTEGRATION` | Run end-to-end browser verification of donor registration and filtering against `SAC-01`–`SAC-03`. | `qa-bot` $\rightarrow$ `secops-bot` | `PHASE-04` |
