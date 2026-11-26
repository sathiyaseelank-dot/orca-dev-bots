# UI Component & Design Specification: <PHASE-XX> — <Feature/View Name>

- **Target Phase**: `PHASE-XX`
- **Parent Sprint**: `SPRINT-XX`
- **Author**: `ui-research-bot`

## 1. UI Objective
<What user problem this UI solves and what visual/interactive experience it must deliver.>

## 2. Reference Websites & Observed Patterns
*(Inspected via Orca embedded browser)*
- **Reference 1 (<Site/URL>)**: <Observed pattern for layout, density, hierarchy, or interaction>
- **Reference 2 (<Site/URL>)**: <Observed pattern for status indicators, forms, or empty states>

## 3. Design Decisions & Reasoning
- <How patterns are adapted to this project's brand and domain rather than copied verbatim>

## 4. Component Hierarchy
```text
<PageContainer>
├── <HeaderBar />
├── <FilterToolbar />
└── <DataDisplay />
    ├── <LoadingSkeleton />
    ├── <EmptyState />
    └── <ErrorBanner />
```

## 5. Layout & Responsive Behavior
- **Desktop (>= 1024px)**: <Grid/column layout, sticky elements>
- **Tablet (768px - 1023px)**: <Breakpoint adjustments, label visibility>
- **Mobile (< 768px)**: <Stacked cards/drawer behavior, touch targets>

## 6. Interaction States
- **Hover / Focus / Active / Disabled**: <Exact Tailwind/CSS state rules>

## 7. Loading, Empty, Error, and Success States
- **Loading**: <Layout-matching skeleton design>
- **Empty**: <Informative message + primary CTA>
- **Error**: <Inline/banner error with retry action>
- **Success**: <Toast or inline confirmation>

## 8. Accessibility Requirements
- Semantic HTML (`<button>`, `<nav>`, `<table>`, `<main>`)
- `aria-label` / `aria-expanded` / `focus-visible` outlines
- WCAG AA contrast compliance

## 9. Existing Components & Design Tokens to Reuse
- **Primitives**: <e.g., `src/components/Button.tsx`, `Card.tsx`>
- **Tokens**: <Exact color palette, typography, spacing, border radius>

## 10. New Components Required
- `<NewComponent1.tsx>`: <Single responsibility>

## 11. Implementation Acceptance Criteria
- **UI-AC-01**: <Testable UI/UX requirement>
- **UI-AC-02**: <Testable UI/UX requirement>
