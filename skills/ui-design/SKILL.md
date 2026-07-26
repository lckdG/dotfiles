---
name: ui-design
description: >
  General mobile/game UI/UX design principles — component sizing (buttons,
  toggles, checkboxes), a typography scale with usage rules, layout/grid, and
  color palette accessibility, given as px on a 1920×1080 design canvas plus
  a rule that all sizing must be even numbers. Use when designing or
  reviewing any screen, component, or palette, checking a design against
  best practice, or before finalizing UI assets/mockups. Trigger: "review
  this UI/design", "check touch target/contrast/sizing", "UI design
  principles", "is this accessible", "new screen/component design", "what
  text size should this be".
---

Checklist + reference for UI/UX decisions on mobile apps and games. Pull the relevant section when designing, reviewing, or critiquing a screen/component/palette/type scale. Not a generator — constraints to check work against. Adapt the canvas resolution and brand palette per project; the structure and ratios below stay project-agnostic.

**Canvas assumption**: all pixel values below are for a **1920×1080 design/reference canvas**, at ~2x density — 1 mobile dp/pt ≈ 2 canvas px. If a project uses a different reference resolution or Canvas Scaler setup, re-derive by the same ratio rather than reusing these numbers as-is.

## Rule of 2 (no odd numbers)

Every size, margin, padding, and gap — component dimensions, font sizes, spacing, corner radius, stroke width — must be an **even number**, and preferably a multiple of a shared base unit (8px works well at this canvas density). Never land on an odd px value (e.g. 45, 57, 33px) even if a size calculation produces one — round to the nearest even number instead. This keeps every value divisible cleanly for @2x/@3x export and Canvas Scaler math, and keeps the whole system feeling deliberate rather than arbitrary. All tables below already follow this rule — when deriving a new size, round to it too.

## Core principles

- Simplicity first — touch controls must work flawlessly on small screens; don't overcrowd.
- Icon/image over text — if meaning is learnable at a glance from a glyph, icon, or illustrative image, use that instead of a text label; reserve text for what can't be shown visually (names, scores, dynamic values, anything needing precision). Applies to labels, badges, buttons, and status markers alike — don't pair an icon with a redundant word once the icon alone reads clearly in context.
- Progressive disclosure — introduce mechanics/UI one at a time, not all at once.
- Visual hierarchy — size/color/contrast pulls the eye to the one critical action per screen.
- Consistent feedback — every interactive element has a visible pressed/active/focus state.
- Accessibility — scalable text, colorblind-safe palette, state never conveyed by color alone.
- Retention stakes are real: ~70% of users/players abandon a product in the first 15 minutes over bad UI/UX — first-run flow must be near-frictionless.

## Component sizing (px @ 1920×1080 canvas)

Size interactive controls by a **three-tier height system**, matched to the weight of the action rather than one flat floor for everything:

| Tier | Height | Used for |
|---|---|---|
| **Primary** | 96px | Full-width/near-full-width CTA buttons — the one critical action on the screen (submit, confirm, start). Width 176px+. |
| **Secondary** | 72px | Inline/supporting controls — icon buttons, tab pills, chip/segmented selectors, list-row actions, back-button, in-flow toggles. |
| **Tertiary** | 48px | Text-only links for low-frequency or de-emphasized actions — cancel, dismiss, secondary navigation, "read more" style links. |

All sizes are **hit-area** heights (the tappable region), not visual/icon size — a small icon or short label can sit inside a taller invisible hit box. Width is driven by content/layout, not the tier.

Platform guidelines (Apple HIG, Material Design) put the accessibility-minimum hit target at 88–96px (44–48dp) for *any* control, primary or not. The Secondary and Tertiary tiers above spend some of that margin on visual density and hierarchy instead — a reasonable trade for casual apps/games where a mistapped tab or link costs nothing to recover from. Move Secondary controls back up to 88–96px, and drop Tertiary entirely in favor of Secondary-sized buttons, on anything accessibility-first, one-handed/thumb-constrained, or where mistaps are costly (payment flows, destructive confirms without an undo).

Component-specific notes:
- **Toggle / switch**: 96×64px track as the accessibility-first default; 88×48px is an acceptable thinner variant in dense layouts (still pad the tap target beyond the visual track, don't shrink hit area below the visible track size).
- **Checkbox / radio**: 36–48px visual box inside a Secondary-tier (72px+) hit area — never make the tappable region equal to the tiny visual box.
- **Stepper +/-, list rows**: Secondary tier (72px) is the floor; go to Primary tier (96px) if the row is itself a primary action (e.g. a joinable list row where the row's own action is the point of the screen).

Spacing rules:
- Minimum 16px gap between any two adjacent targets, regardless of tier.
- Primary actions live in the thumb-reach zone: bottom-center / bottom-third of the canvas for one-handed portrait use. Avoid placing primary CTAs in top corners.
- Panel padding: keep top/bottom and left/right padding symmetric within the same panel (44–54px is a comfortable range at this canvas size). Vertical rhythm between stacked rows: one larger gap between sections (24–32px), one smaller gap between a label and its control (8–12px) — pick two values and reuse them, don't let gaps drift row to row.

## Typography scale & usage (px @ 1920×1080 canvas)

Define a fixed scale, don't pick sizes ad hoc per screen. Base body size 32px; steps below use a ~1.15–1.2x ratio per step, capped at 80px for the largest role.

| Role | Size (px) | Usage |
|---|---|---|
| Display / hero title | 64–80 | Screen titles, splash/logo wordmark, key popup headlines |
| Section header | 48–56 | Panel/card titles, tab section labels |
| Button label | 36–40 | Primary/secondary button text — must stay legible at arm's length |
| Body / input text | 32–34 | Form fields, list entries, settings labels |
| Caption / meta | 26–28 | Timestamps, helper text, counts, small badges |
| Micro / badge number | 22–24 | Chip counts, notification dots — use sparingly, never for anything actionable |

Rules:
- Never go below 26px for any text a user must read to use the product (accessibility floor). Micro tier is for glanceable numbers only, not instructions.
- Max 2 type families total: one UI/body family, one display/accent family. Don't introduce a third weight family for "just one screen."
- Author sizes as relative/scalable units in the actual implementation (Canvas Scaler / em / sp), not hardcoded px — the px table above is for laying out the 1920×1080 canvas, not the shipped pixel value on every device.
- Contrast must be checked at the actual weight+size pair used (APCA/WCAG 3.0: contrast is a function of weight, size, and polarity) — a bold 80px header and a regular 26px caption need separately verified contrast, not one check for the whole palette.

## Layout & grid

- Design at the 1920×1080 canvas, keep all component/type sizes as ratios of it — never hardcode a px value that assumes this exact canvas won't get scaled.
- Respect safe areas (notch, home indicator, rounded corners) — keep interactive/critical elements at least ~24px clear of any canvas edge, more on rounded-corner devices.
- Prefer calmer UIs: fewer simultaneous on-screen actions, one clear focal action, decoration never competes with function.
- Keep spacing/icon size/animation timing consistent across screens — inconsistency slows user learning.

## Color palette & accessibility

- Distribute color with the 60-30-10 rule: 60% dominant (background), 30% secondary (panels/surfaces), 10% accent (CTA/highlights).
- Contrast ratio minimums (WCAG): 4.5:1 normal text, 3:1 large text/headlines — measure with a checker, never eyeball, and re-check per type-scale row above.
- Resolve translucent fills to their effective blended color before measuring contrast — a semi-transparent overlay's raw fillColor (e.g. white at 6% opacity) reads nothing like what actually renders.
- Never convey state by hue alone — pair every color-coded state (on/off, active/error/success) with a shape, icon, or position change too.
- Never use red+green as the sole differentiator — most common colorblind confusion pair.
- Pick one deliberate color scheme (complementary/analogous/triadic) tied to the product's mood, not ad-hoc additions.
- Run the palette through a colorblind simulator (Coblis, Color Oracle) before locking in — check confusable pairs (e.g. orange/yellow vs red/green under deuteranopia/protanopia).

## Per-project checklist

When applying this skill to a specific project, record and verify:
- Actual brand palette hex values and font families (replace this section with project specifics).
- Palette run through a colorblind simulator — flag any confusable accent pairs.
- Text-on-background contrast at actual weight/size used, for every color pair in the palette.
- Hit-area size on custom components (steppers, list rows, sliders) vs their visual size.
- Safe-area clearance for any persistent top/bottom-anchored UI on notched or gesture-nav devices.
