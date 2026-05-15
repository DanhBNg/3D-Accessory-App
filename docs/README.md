# Flutter 3D Accessory Docs

This folder keeps the current project context compact. Removed docs should not be recreated unless they add information that is not already covered here.

## Recommended Reading Order

1. [Project overview](project-overview.md)
2. [Architecture](architecture.md)
3. [Asset guide](asset-guide.md)
4. [Roadmap](roadmap.md)
5. [Shared character animation guide](shared-character-animation-guide.md)
6. [3D AI tooling guide](3d-ai-tooling-guide.md)
7. [3D model prompt guide](3d-model-prompt-guide.md)

## Current App Areas

- `cinematic_vfx`: mock cinematic VFX UI and video previews.
- `character_3d`: rigged character preview plus optional accessory overlay controls.
- `character_room`: fixed-room viewer with rigged characters and reusable Mixamo-style animation GLBs.

## Current Heavy Assets

```text
assets/models/room/room_default.glb
assets/models/characters_rigged/character_1.glb
assets/models/characters_rigged/character_2.glb
assets/models/characters_rigged/character_3.glb
assets/models/animations/breathing_idle.glb
assets/models/animations/jumping_down.glb
assets/models/animations/spin_act.glb
assets/models/animations/hip_hop_dancing.glb
```

The APK will stay large while these GLBs are bundled in `pubspec.yaml`. For the lightest app, move GLB assets to a CDN and keep only `assets/web/` plus small config/fallback assets in the app bundle.

## Current Room Behavior

- Room is scaled up in `assets/web/character_room_viewer.html`.
- Room/camera are fixed.
- Horizontal drag rotates only the character around the Y axis.
- Character floor offset is `0.48`.
- Room floor is aligned to `0`.
- `breathing_idle.glb` plays automatically when entering the room or switching character.

## Local Helper Files

`check_glb.dart` and `check_glb.py` are local helper scripts. They are not part of the committed app unless intentionally added later.
