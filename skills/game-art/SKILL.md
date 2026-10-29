---
name: game-art
description: >
  Conceptual framework for game art and game UI decisions — readability,
  silhouette, value and palette construction, lighting, environment
  wayfinding, UI/text/icon harmony, animation readability, and genre and
  platform trade-offs, with dos and don'ts per area. Use when designing,
  critiquing, or planning game visuals, art direction, style guides,
  HUD/menus, or game art assets. Trigger: "design the UI", "design the HUD",
  "design the art for my game", "create an art style guide", "pick a palette
  for my game", "plan the art direction", "make a game asset/icon/sprite",
  "review this art style", "is this readable", "palette feedback", "game art
  direction", "why does this game look/read like this", "does the UI match
  the world art".
---

# Game Art Principles

Constraints and concepts to design with and check work against. Adapt per project; the structure and ratios stay project-agnostic.

## Design and asset tasks

What this skill produces directly: art direction, style guides and art bibles, palettes with roles, type and icon rules, UI specs and layouts, written briefs and image prompts, and reviews against the checklist below.

For asset tasks (characters, props, environments, icons, sprites, backgrounds, concept art, UI art):
- **Prioritize a separate image generation model** over hand-written vector graphics (SVG, code-drawn shapes). Vector output from a text agent is a last resort, not the default.
- Run Preflight first, then write the prompt from it: style and reference, palette hex with roles, camera and viewing distance, silhouette and shape language, lighting direction, background, target size and format.
- Check each generated result against the Review checklist (silhouette, grayscale, palette roles, readability at real size). Iterate the prompt, not the checklist.
- Use vector or code only when no image model is available, when the user asks for it, or for simple geometric UI where an exact, scalable shape is the requirement. Say so when falling back.
- If no image model is available at all, deliver the brief and prompt set and say assets still need to be generated.

Pixel values below assume a **1920×1080 reference canvas**; re-derive by ratio for other resolutions. Keep icon sizes and strokes to even numbers, multiples of an 8px base unit where possible, so they scale cleanly.

Numeric values are starting points. Confirm against the project's own specs and engine docs before relying on them.

## Preflight (do before any real work)

Do not jump into critique, design, or generation until the facts below are known. Find them in the project first (style guide, art bible, README, design docs, engine/project settings, asset folders, existing screens), then ask the user only for what cannot be found. If something stays unknown, state the assumption you are proceeding on.

| Verify | Why it matters | Where to look |
|---|---|---|
| Genre and core loop | Sets the weight between mood and function | Design doc, README, store page |
| Platform and input device (mobile touch, PC, console/controller, VR) | Sets reading distance, UI scale, safe zones, hit areas, budgets | Build settings, target specs |
| Camera type and gameplay distance (2D, top-down, third/first person, fixed or free) | Decides silhouette scale, lighting approach, wayfinding | Scenes, camera rig, concept art |
| Existing art direction (style guide, art bible, references, mood boards) | Work must match or deliberately extend it | Docs, `assets/`, design folders |
| Current palette, roles, semantic colors | Prevents ad hoc colors and role clashes | Theme/token files, style guide |
| Fonts in use (display face vs gameplay/UI face) | Prevents a third typeface and unreadable gameplay text | Font assets, theme files |
| UI approach (diegetic or overlay) and reference canvas/resolution | Decides how UI relates to world art and how px values scale | UI scenes, canvas scaler settings |
| Budgets (polygons, textures, lighting model, draw/atlas limits) | Style must fit what the platform can afford | Engine settings, tech art docs |
| Accessibility targets (colorblind support, text scaling, subtitles, contrast) | Decides which redundancy and options are mandatory | Design doc, settings screen |
| Localization needs | Decides text space and icon-versus-text balance | Project requirements |
| Task scope (new asset, review, style guide, UI screen, palette) | Picks which sections below apply | The request itself |

Then record the answers in a short project note (palette hex with roles, fonts, platform, camera, budgets, targets) and reuse it for the rest of the task.

If the task falls in an area this skill covers thinly — aerial perspective and depth cueing, material and environment modeling, character design, VFX, controller and 10-foot console UI, genre-specific conventions for strategy, racing, puzzle, or horror — say so, lean on the project's own references and existing shipped examples, and flag the result as less certain.

## Core model

Game visuals differ from app visuals in goal. An app succeeds when it disappears and the task finishes with least friction. A game succeeds when the player feels something, and friction (challenge, tension, discovery) is often the point. Visuals are the content, not chrome around it. Hierarchy, consistency, accessibility, and user testing apply to both.

1. **Art is information design under constraint.** Every visual choice tells the player something, with a required reading speed. Faster decision = plainer form.
2. **Perception order:** value and silhouette (instant), then color and motion, then shape detail, then text and fine detail. Design top-down. Embellishment lives in the later layers.
3. **Contrast is a budget.** Strong contrast, saturation, and motion pull the eye. Spend them on what the player must see now. Keep the rest quiet.
4. **Style is a constraint system, not decoration.** A small set of shapes, colors, materials, motion rules applied everywhere gives cohesion and lowers cognitive load.
5. **Style serves the experience goal.** Mood and function choose the rules. Genre sets the weight between them.
6. **Real constraints shape style.** Camera freedom, platform budgets, resolution, production cost feed back into the style guide.
7. **Accessibility is the same principle for wider players.** Redundant channels (value, shape, text) are readability insurance.
8. **Verify in context.** Real camera distance, engine lighting, target display, real players.

**Do**
- Decide what the player must perceive first, then design the order of everything else around it.
- Write the style rules down so every asset follows them.
- Treat friction as a design choice, not a bug.

**Don't**
- Judge by "it looks good" in the editor or a zoomed-in view.
- Copy an app's "clean, minimal, frictionless" instincts into a game without asking whether the friction is the experience.
- Let individual brilliance break the shared rules.

## Readability

Players read the screen under load (action, time pressure, moving camera), so the bar is stricter than for a form or dashboard.

- Key objects read as solid black silhouettes at gameplay camera distance.
- Shape language: circle = friendly, square = stable/strong, triangle = tense/dangerous.
- TF2 example: highest contrast at chest/weapon level, darker feet — detail sits where the eye goes.

**Do**
- Design silhouette and shape before material and detail.
- Run the silhouette test (solid black) and the grayscale test.
- Put detail in the player's focus area.
- Test at real camera distance and on the target display.

**Don't**
- Rely on color or texture to make a shape readable.
- Add noisy surfaces or high-contrast detail in non-critical areas.
- Give different roles similar silhouettes and proportions.

## Palette

Color in a game carries mood, state, and navigation, not just brand and hierarchy.

- **Value before hue.** Set dominant value distribution first, then hue and chroma. A hue scheme (complementary, analogous) is not a palette.
- Give colors roles: dominant (about 60% environment/base), subordinate (about 30%), accent (about 10%). Keep value structure consistent across variations.
- Neutral base so accents read (Mirror's Edge: off-white city, red = path).
- Color script: plan palette per level or story beat (Journey, Hades). Palette weight shifts change mood without redrawing assets.
- Fixed semantic colors (health, danger, reward) are the exception to the world palette.
- Constraint reads as quality (pixel art: PICO-8 and Celeste lineage).

**Do**
- Start from a small, intentional palette with defined roles.
- Reserve saturation for gameplay-critical things.
- Check hues under real engine lighting, since they shift.
- Match palette to mood and genre (desaturate for dread, warm light as safety).

**Don't**
- Pick hues first and fix value later.
- Add colors ad hoc per asset.
- Spend accent colors on decoration.
- Reuse a semantic color (red = danger) for something unrelated.

## Lighting

Light is the value-structure tool. Fill sets overall range, key shapes form and focal areas, rim separates silhouette. The camera moves, so a setup must hold from many angles; a fixed-viewport mockup does not.

- Bright spot in a dark area draws the player. Warm soft = safe/important. Harsh/dark = tension.
- Film three-point lighting assumes a controlled camera. Levels often use ambient plus many soft invisible fills.

**Do**
- Set the base value range first, then add key, then rim.
- Use light to direct attention to goals and exits.
- Re-check rim and key from the angles players actually use.

**Don't**
- Light a scene only from the hero camera angle.
- Let lighting flatten value separation between foreground and background.
- Use light cues that conflict with the navigation cues of the level.

## Environment and wayfinding

In games, guidance is mostly implicit: the environment is the navigation UI. Apps use explicit labels, buttons, and menus.

- Tools: landmarks, leading lines, light, framing, breadcrumbs, color coding.
- Level designer and environment artist work together so areas stay recognizable.

**Do**
- Give each area a recognizable landmark or silhouette.
- Direct the eye with leading lines, light, and framing toward the goal.
- Put detail budget in the player area.
- Playtest whether players find the path without prompts.

**Don't**
- Make cues so obvious they break immersion, or so subtle players get lost.
- Rely on a minimap or arrows to cover for illegible space.
- Spread detail evenly so nothing stands out.

## UI, text, icons

Game UI has a fiction layer that apps lack. UI either lives inside the world's fiction (diegetic) or deliberately sits outside it. It is part of the art, not chrome.

- **Visual language first:** document shapes and their meanings, fonts with usage, palette, corner radius, border/material treatment in a UI art bible.
- UI is related to world art, not identical. Copying it exactly makes UI blend into the scene.
- Placement types: non-diegetic (clear, costs immersion), diegetic (immersive, costs clarity), spatial, meta. Evidence on immersion benefit is mixed. Choose by tone and experience.
- **Typography:** themed display face for logo/titles/flavor. Plain high-contrast sans for gameplay text and subtitles. Subtitles >= 46 px at 1080p (TV/video guidance), letter spacing >= 0.12x size, backing panel or outline over busy backgrounds, player-adjustable size.
- **Icons:** one stroke weight, shared keylines, same shading model across the set, design for smallest size first. Game backgrounds are busier than app backgrounds, so fills and contrast may need to be heavier. Game icons may deliberately differ from world art (bright, clean, saturated) for recognition.

**Do**
- Define shape motifs, fonts, icon rules, and corner/border treatment in a UI art bible.
- Reuse world palette accents in UI, plus fixed semantic colors.
- Use a themed face only where it is not read mid-action.
- Review icons as a set at real display size, over real backgrounds.
- Test menus and in-game overlays separately.

**Don't**
- Copy world art exactly into UI, or ignore it entirely.
- Let the display font carry gameplay-critical text.
- Use more than two or three typefaces.
- Pick diegetic UI at the cost of reading critical information.
- Assume UI that works on a plain app background works over gameplay.

## Priority: information vs style vs text

Order of protection, most to least:
1. Gameplay-critical info (health, ammo, timers, prompts, subtitles): legible and high-contrast. Art bends to fit.
2. Information hierarchy: most significant first.
3. Style of the carrier (font, icon shape, frame, material): match the world within legibility limits.
4. Decoration: first to cut.

- Icons beat text for fast, frequent info. Text beats icons for complex or rare meaning. Icon first, description on hover/inspect.
- Environment and art beat text for teaching (show, don't tell). Unlike an app, a game need not explain every control up front; discovery can be part of the experience.
- Icons and color reduce localization cost. Leave room for longer translations.
- Rule: style decides how info looks, never whether it can be read. Cut decoration before legibility.

**Do**
- Use redundancy (text + icon + color) for critical, ambiguous, or first-seen info; drop the redundant label once the symbol is learned and the context is unambiguous.
- Teach through visual cues and contextual hints before text walls.
- Pair color-coded states with shape, icon, or label.

**Don't**
- Hide critical info behind style.
- Use text where an icon would be read faster during action.
- Use icons for complex meaning that needs words.
- Put long text in high-pressure moments.

## Animation

Same principles as film, reweighted for interaction. A game is responsive: input must feel instant.

- Player actions respond instantly (little anticipation). Enemy attacks get longer anticipation (telegraphing = fairness).
- Squash/stretch sells weight and impact. Full cartoon use is a tonal choice.

**Do**
- Give enemy attacks readable wind-ups and quick recoveries.
- Keep player response frames short.
- Make motion readable at the intended camera distance.

**Don't**
- Add film-style anticipation to player inputs, which feels sluggish.
- Hide attack telegraphs in clutter, motion blur, or low contrast.
- Push squash/stretch beyond the game's tone.

## Genre and platform

- Competitive/fast: instant identification, silhouette, team color, readability over detail.
- Navigation-heavy: color/light as the map.
- Narrative: palette as emotional curve.
- Horror/dark fantasy: desaturate, rare warm light reads as safety.
- Menu-heavy/stylized (Persona 5): style may lead, but clarity cost is real and dev cost high.
- Mobile/casual: flat/vector styles are cheap and scale well.
- Pixel art: palette limit is a constraint turned into style.
- Budgets (polygons, textures, lighting model) depend on platform, camera distance, pipeline. Decide early, record in a technical art style guide.

**Do**
- Pick the style for the experience goal, then check it against platform and budget.
- Decide budgets and texture/lighting rules before making assets.
- Note two spec tiers (high/low) when shipping on multiple platforms.

**Don't**
- Choose a style your pipeline or platform cannot afford.
- Copy a reference game's look without matching its constraints and goal.
- Use hard numeric budgets without checking current engine docs.

## Accessibility

- Never color alone. Add shape, icon, pattern, label. Value difference is the strongest second channel.
- Okabe-Ito palette (blue/orange pair) is a common safe base.
- One colorblind mode mostly covers red-green. Prefer customizable colors.

**Do**
- Check key distinctions in grayscale.
- Test with CVD simulators and real players.
- Offer text size and contrast options.

**Don't**
- Use red vs green (or any single hue pair) as the only differentiator.
- Ship one fixed colorblind palette and call it done.
- Treat accessibility as a late polish pass.

## Review checklist

- [ ] Preflight facts verified and recorded.
- [ ] Silhouette test, grayscale test.
- [ ] Palette run through a colorblind simulator; confusable accent pairs flagged.
- [ ] Dominant/subordinate/accent roles defined; semantic colors fixed.
- [ ] Contrast budget spent on gameplay-critical items only.
- [ ] Value structure checked in engine lighting at gameplay camera.
- [ ] Wayfinding cues exist and are playtested.
- [ ] UI art bible: shapes, fonts, icon rules, palette.
- [ ] Gameplay text plain and legible; subtitle size, contrast, backing, scaling options.
- [ ] No info carried by color alone.
- [ ] Style fits platform and budget; constraints written down.
- [ ] Tested on target display with real players.
