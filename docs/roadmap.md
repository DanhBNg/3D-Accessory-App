# Roadmap

## Phase 1 - Stable Demo

Status: implemented.

- Keep the Cinematic VFX mock flow running.
- Keep the 3D accessory viewer working with local GLB assets.
- Support basic accessory toggling and category selection.
- Keep the codebase feature-first and clean-lite.

## Phase 2 - Character Room Shared Animation Demo

Status: implemented for the first demo pass.

Current demo scope:

- Room model: `assets/models/room/room_default.glb`
- Rigged characters:
  - `assets/models/characters_rigged/character_1.glb`
  - `assets/models/characters_rigged/character_2.glb`
  - `assets/models/characters_rigged/character_3.glb`
- Animation-only files:
  - `assets/models/animations/breathing_idle.glb`
  - `assets/models/animations/jumping_down.glb`
  - `assets/models/animations/spin_act.glb`
  - `assets/models/animations/hip_hop_dancing.glb`
- Viewer: `assets/web/character_room_viewer.html`
- Screen: `CharacterRoomScreen`

Important rule:

- Characters and animations must share a compatible Mixamo skeleton.
- The viewer maps the two common Mixamo naming variants:
  - `mixamorigHips`
  - `mixamorig_Hips`
- Root/Hips vertical position is grounded so actions stay on the character floor offset `0.48`.
- The room floor is kept at `0`, and the room camera stays fixed while horizontal drag rotates only the character.

Next improvements:

- Replace placeholder/test character files with final optimized mobile GLBs.
- Keep `breathing_idle.glb` as the default entry animation.
- Prefer in-place animation exports from Mixamo when available.
- Move large `.glb` files to Git LFS if the repo continues to store binary assets.

## Phase 3 - Asset Size And Mobile Optimization

Status: pending.

Recommended work:

- Compress textures before exporting GLB.
- Reduce mesh poly count for mobile.
- Remove unused demo assets from `pubspec.yaml`.
- Avoid committing temporary `.model` files unless the app directly uses them.
- Consider Draco or meshopt compression if the viewer pipeline supports it.
- Consider Git LFS for GLB files larger than 50 MB.

## Phase 4 - Accessory Expansion

Status: optional.

Only expand this if the accessory editor remains part of the demo goal.

Possible work:

- Add more hair, hat, glasses, mask, outfit assets.
- Add thumbnails for every visible item.
- Replace hard-coded transforms with config-driven transforms.
- Support per-character accessory transforms.
- Add a clearer selected/accessory state model.

## Phase 5 - Backend Or AI API

Status: future.

Only add full Clean Architecture layers when there is a real backend or API need:

- AI generation API.
- User inventory.
- Remote asset download.
- Login/profile.
- Payment or unlock flow.

At that point, add:

```text
data/
  datasources/
  dto/
  repositories/
domain/
  repositories/
  usecases/
presentation/
  state/
```
