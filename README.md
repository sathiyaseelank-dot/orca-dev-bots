# Orca Autonomous Fullstack Development Bots

A reusable multi-agent software engineering team for the Orca IDE (Stably).

## The Team

| Bot | Handle | Role |
| :--- | :--- | :--- |
| **Product / Spec Lead** | `bot:product-bot` | Architect, technical specifications (`SPEC.md`), testable Acceptance Criteria (`AC-xx`), item tracking. |
| **Fullstack Developer** | `bot:dev-bot` | Fullstack implementation across frontend/backend in isolated git worktrees. |
| **QA & Acceptance Tester** | `bot:qa-bot` | Dynamic test runner (`npm test`, `pytest`, `cargo test`), Orca browser testing, acceptance criteria validation. |
| **Security & DevOps** | `bot:secops-bot` | Secret scanning, vulnerability audit, GitHub PR lifecycle, CI monitoring, and deployments. |

## Workflow & Feedback Loop

1. Give any project goal to **`product-bot`**.
2. `product-bot` writes `docs/SPEC.md` and `docs/ACCEPTANCE_CRITERIA.md`, then hands off to `dev-bot`.
3. `dev-bot` writes the implementation on a new branch in an isolated child worktree.
4. `dev-bot` requests review from `qa-bot`.
5. `qa-bot` runs tests:
   - If any test fails, it sends logs back to `dev-bot` to patch and resubmit.
   - When 100% pass, it hands off to `secops-bot`.
6. `secops-bot` runs security audits, opens a GitHub PR, verifies CI, and deploys.

## Exporting & Importing to Another Machine

Clone this repository into `~/.orca/bots` on any machine with Orca installed:
```bash
git clone <your-repo-url> ~/.orca/bots
```
Orca will immediately register all 4 bots.
