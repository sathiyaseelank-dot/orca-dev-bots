# Phase: <PHASE-XX> — <Short Cohesive Task Title>

- **Phase ID**: `PHASE-XX`
- **Parent Sprint ID**: `SPRINT-XX` *(or `HOTFIX`)*
- **Phase Type**: `DATABASE` | `BACKEND` | `API_CLIENT` | `UI_RESEARCH` | `UI_IMPLEMENTATION` | `INTEGRATION` | `HOTFIX`
- **Assigned Owner**: `dev-bot` *(DATABASE, BACKEND, API_CLIENT, INTEGRATION, backend HOTFIX)* | `ui-research-bot` *(UI_RESEARCH)* | `ui-bot` *(UI_IMPLEMENTATION, UI HOTFIX)*
- **Requires UI Research**: `false` | `true`
- **Completion Status** *(updated solely by `sprint-orchestrator-bot`)*: `PENDING` | `READY` | `IN_PROGRESS` | `REVIEW` | `PASS` | `FAILED` | `BLOCKED`
- **Retry Count**: `0 / 3` *(escalate to owner if 3)*

## 1. Task Objective
<Exactly ONE small, finishable implementation objective.>

## 2. Required Dependencies
- <e.g., `PHASE-01` (`PASS`) — or `None`>

## 3. Input Files & Relevant Components
- `<path/to/file1>`
- `<docs/DESIGN_SYSTEM.md>` *(if UI phase)*
- `<docs/ui-specs/PHASE-XX-UI-SPEC.md>` *(if UI_IMPLEMENTATION phase)*

## 4. Explicit Scope
- <Exact change 1 required to complete this single objective>
- <Exact change 2 required to complete this single objective>

## 5. Explicit Out-of-Scope Items
- Do NOT implement future phases.
- Do NOT refactor unrelated modules or endpoints.
- Do NOT edit this phase's Completion Status directly (report results to `sprint-orchestrator-bot`).
- <Specific exclusions for this phase>

## 6. Acceptance Criteria
- **AC-01**: <Specific, verifiable check for this phase>
- **AC-02**: <Specific, verifiable check for this phase>

## 7. Verification Commands & Test Requirements
```bash
# Exact commands that must pass before REVIEW -> PASS
```

## 8. Expected Output
- <Exact files created/modified, passing test output, and summary to report to `sprint-orchestrator-bot`.>
