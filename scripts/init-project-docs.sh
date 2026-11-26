#!/usr/bin/env bash
set -euo pipefail

# Bootstrap ORCA sprint, phase, and UI spec directories in a target project repository.
TARGET_DIR="${1:-.}"

mkdir -p "$TARGET_DIR/docs/sprints" \
         "$TARGET_DIR/docs/phases" \
         "$TARGET_DIR/docs/ui-specs"

if [ ! -f "$TARGET_DIR/docs/DESIGN_SYSTEM.md" ]; then
  cat << 'EOF' > "$TARGET_DIR/docs/DESIGN_SYSTEM.md"
# Project Design System

Maintained by `ui-research-bot` and consumed by `ui-bot` and `ui-review-bot`.

## 1. Brand & Color Tokens
- Primary / Accent: `<TBD>`
- Neutral Surface / Canvas: `<TBD>`
- Semantic Status (Healthy / Warning / Critical): `<TBD>`

## 2. Typography & Spacing Scale
- Font Family: `<TBD>`
- Scale: `4px, 8px, 12px, 16px, 24px, 32px`

## 3. Reusable UI Primitives
- `<Button />`, `<Card />`, `<Table />`, `<Modal />`, `<Badge />`
EOF
fi

echo "Initialized ORCA docs structure in $TARGET_DIR/docs/"
