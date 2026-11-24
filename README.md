# Orca Autonomous Fullstack Development Bots

A reusable multi-agent software engineering team for the Orca IDE (Stably).

## The Team

| Bot | Handle | Role |
| :--- | :--- | :--- |
| **Product / Spec Lead** | `bot:product-bot` | Architect, technical specifications (`SPEC.md`), testable Acceptance Criteria (`AC-xx`), item tracking. |
| **Fullstack Developer** | `bot:dev-bot` | Fullstack implementation across frontend/backend in isolated git worktrees. |
| **UI Component Architect** | `bot:ui-bot` | Project-aware UI analysis, design-system consistency, and production component refactoring (skeletons, empty states, a11y, responsive design). |
| **UI/UX Design Auditor** | `bot:ui-review-bot` | Independent visual review, benchmark audits via Orca browser, exact CSS/Tailwind correction specs, and aesthetic verification sign-off. |
| **QA & Acceptance Tester** | `bot:qa-bot` | Dynamic test runner (`npm test`, `pytest`, `cargo test`), Orca browser testing, acceptance criteria validation. |
| **Security & DevOps** | `bot:secops-bot` | Secret scanning, vulnerability audit, GitHub PR lifecycle, CI monitoring, and deployments. |

## Workflow & Feedback Loop

```
User Goal / Spec Request
         │
         ▼
    product-bot  ──(SPEC.md & ACCEPTANCE_CRITERIA.md)──▶ dev-bot
                                                            │
                     ┌──────────────────────────────────────┴──────────────────────────────────────┐
                     ▼                                                                             ▼
               Backend Logic                                                                 Frontend UI Code
                     │                                                                             │
                     │                                                                             ▼
                     │                                                                          ui-bot
                     │                                                      (Audits design system & refactors into
                     │                                                       reusable, accessible components)
                     │                                                                             │
                     │                                                                             ▼
                     │                                                                      ui-review-bot
                     │                                                      (Independent visual audit in Orca browser,
                     │                                                       audits benchmarks, produces exact CSS specs,
                     │                                                       and confirms aesthetic polish)
                     │                                                                             │
                     └──────────────────────────────────────┬──────────────────────────────────────┘
                                                            ▼
                                                         qa-bot
                                            (Runs tests & validates ACs in
                                                Orca embedded browser)
                                                            │
                                                            ▼
                                                        secops-bot
                                            (Security audits, GitHub PRs,
                                                CI verification, deploy)
```

1. Give any project goal to **`product-bot`**.
2. `product-bot` writes `docs/SPEC.md` and `docs/ACCEPTANCE_CRITERIA.md`, then hands off to `dev-bot`.
3. `dev-bot` writes the implementation on a new branch in an isolated child worktree.
4. When frontend code is written, `dev-bot` hands off to **`ui-bot`**:
   - `ui-bot` audits existing project primitives and design tokens.
   - `ui-bot` refactors raw UI into production-ready, accessible, responsive components without breaking backend logic.
5. **`ui-review-bot`** inspects the live rendered UI in Orca embedded browser:
   - Evaluates visual hierarchy, spacing, contrast, and tablet/mobile viewports.
   - Delivers prioritized, exact CSS/Tailwind correction specs with code diffs.
   - Verifies and confirms the corrections once applied.
6. The completed, visually polished branch is submitted to **`qa-bot`**.
7. `qa-bot` runs automated tests and visual browser checks:
   - If tests fail, it sends feedback to `dev-bot` / `ui-bot` to patch and resubmit.
   - When 100% pass, it hands off to **`secops-bot`**.
8. `secops-bot` runs security audits, opens a GitHub PR, verifies CI, and deploys.

## Exporting & Importing to Another Machine

Clone this repository into `~/.orca/bots` on any machine with Orca installed:
```bash
git clone <your-repo-url> ~/.orca/bots
```
Orca will register all 6 bots.
