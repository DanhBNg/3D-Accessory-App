# Flutter 3D Accessory - Project Docs

This folder contains handoff notes, asset workflow notes, and implementation guides for the Flutter 3D demo.

## Contents

- [Project overview](project-overview.md)
- [Architecture](architecture.md)
- [Roadmap](roadmap.md)
- [Asset guide](asset-guide.md)
- [3D character implementation](character-3d-implementation.md)
- [Character room feature plan](character-room-feature-plan.md)
- [Shared character animation guide](shared-character-animation-guide.md)
- [3D AI tooling guide](3d-ai-tooling-guide.md)
- [3D model prompt guide](3d-model-prompt-guide.md)
- [Handoff checklist](handoff-checklist.md)

## Current Status

The project is a Flutter demo with three main experience areas:

- `cinematic_vfx`: mock cinematic VFX UI and video previews.
- `character_3d`: accessory viewer using WebView, local asset server, and Three.js.
- `character_room`: room viewer with rigged characters and reusable Mixamo-style animation GLBs.

The current architecture is feature-first and clean-lite. Full Clean Architecture layers should be added only when a backend, AI API, inventory, or remote asset pipeline is introduced.

## Current Character Room Demo

Current room assets:

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

The reusable animation workflow is documented in:

```text
docs/shared-character-animation-guide.md
```
