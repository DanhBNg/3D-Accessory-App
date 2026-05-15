# 3D AI Tooling Guide

Use this guide for creating new room characters and animation files.

## Current Target

The app expects rigged humanoid characters and reusable Mixamo-style animation-only GLBs.

Current examples:

```text
assets/models/characters_rigged/character_1.glb
assets/models/characters_rigged/character_2.glb
assets/models/characters_rigged/character_3.glb

assets/models/animations/breathing_idle.glb
assets/models/animations/jumping_down.glb
assets/models/animations/spin_act.glb
assets/models/animations/hip_hop_dancing.glb
```

## Character Workflow

Recommended simple workflow:

1. Start with a humanoid character model.
2. Upload to Mixamo.
3. Auto-rig.
4. Download:

```text
Format: FBX Binary
Skin: With Skin
Pose: T-Pose
```

5. Import into Blender.
6. Reconnect original textures if Mixamo did not preserve them.
7. Export GLB:

```text
Format: glTF Binary (.glb)
Data: Mesh + Skinning
Materials: Export
Images: embedded/automatic
Animation: optional for character files
```

## Animation Workflow

Use the same Mixamo skeleton style.

Download animation with:

```text
Format: FBX Binary
Skin: Without Skin
```

Convert to GLB in Blender. Animation-only GLBs should normally have:

```text
animations: 1+
meshes: 0
textures/images: 0
```

## Naming Notes

Mixamo may export either:

```text
mixamorigHips
mixamorig_Hips
```

The current viewer maps these two variants. Different skeleton structures still need Blender retargeting.

## Room Asset

Room GLB is static:

```text
assets/models/room/room_default.glb
```

The current viewer scales the room at runtime, so the source room does not need to be huge.

## Size Optimization

Before shipping or sharing APKs:

- lower texture resolution
- reduce mesh poly count
- remove hidden meshes
- avoid embedding unused animations in character GLBs
- prefer CDN/lazy download for large assets

Git LFS is useful for repo storage, not APK size.
