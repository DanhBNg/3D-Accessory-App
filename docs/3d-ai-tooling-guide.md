# 3D AI Tooling Guide

This guide covers the practical asset pipeline for the Character Room and accessory demos.

## Current Character Room Target

The current Character Room demo uses separate character and animation files:

```text
assets/models/characters_rigged/character_1.glb
assets/models/characters_rigged/character_2.glb
assets/models/characters_rigged/character_3.glb

assets/models/animations/breathing_idle.glb
assets/models/animations/jumping_down.glb
assets/models/animations/spin_act.glb
assets/models/animations/hip_hop_dancing.glb

assets/models/room/room_default.glb
```

The goal is reusable animation:

```text
Character 1 + Idle / Jumping Down / Spin / Hip Hop Dance
Character 2 + Idle / Jumping Down / Spin / Hip Hop Dance
Character 3 + Idle / Jumping Down / Spin / Hip Hop Dance
```

## Recommended Workflow For Characters

Use Mixamo for the first production-like demo:

1. Start with a humanoid character model.
2. Upload it to Mixamo.
3. Auto-rig it.
4. Download with:

```text
Format: FBX Binary
Skin: With Skin
Pose: T-Pose
```

5. Open the rigged FBX in Blender.
6. Reconnect materials/textures if Mixamo did not preserve them.
7. Export as GLB:

```text
Format: glTF Binary (.glb)
Data: Mesh + Skinning
Materials: Export
Images: embedded/automatic
Animation: optional for character files
```

## Recommended Workflow For Animations

Use the same Mixamo character/skeleton when downloading animation files.

Download animation with:

```text
Format: FBX Binary
Skin: Without Skin
```

Then convert in Blender to GLB:

```text
assets/models/animations/action_name.glb
```

Animation-only GLBs do not need mesh, material, or texture. They only need animation tracks targeting the compatible skeleton.

## Mixamo Skeleton Notes

Mixamo exports can use different naming variants:

```text
mixamorigHips
mixamorig_Hips
```

The current viewer maps between these two variants. Different skeleton structures still require retargeting in Blender.

## Room Generation

Room assets do not need rigging or animation.

Recommended prompt:

```text
Create a cute stylized compact 3D room interior as a GLB model for a mobile avatar app. The room should have a simple floor, back wall, soft lighting style, and a small empty center area where a chibi character can stand. No character, no people, no text, no logo, no animation. Front-facing composition, floor centered at origin, mobile optimized, simple clean topology, soft rounded toy-like shapes.
```

## Useful Tools

- Mixamo: best for quick humanoid rigging and animation.
- Blender: required for cleanup, texture reconnecting, scale/orientation checks, and GLB export.
- Meshy AI / Tripo AI: useful for generating static character or prop meshes.
- Hunyuan 3D / Seed 3D: useful for static GLB generation, usually needs separate rigging.

## Character Export Checklist

```text
[ ] GLB format
[ ] Has mesh
[ ] Has skeleton/bones
[ ] Has skin weights
[ ] Has materials/textures if color matters
[ ] Mixamo-compatible skeleton
[ ] Feet near ground
[ ] Reasonable scale
[ ] Mobile-friendly file size
```

## Animation Export Checklist

```text
[ ] GLB format
[ ] Has at least one animation clip
[ ] Targets Mixamo-compatible bones
[ ] In-place if the character should not travel around the room
[ ] Root/Hips vertical movement is acceptable
```

## Common Problems

### Character Has No Color

If a rigged GLB reports:

```text
Textures: 0
Images: 0
```

then the color data is not in the file. Reconnect original textures in Blender and export GLB again.

### Animation Does Not Move The Character

Usually caused by:

```text
character has no skeleton/skin
animation targets different bone names or structure
```

Fix by using a rigged character with a compatible Mixamo skeleton.

### Character Floats During Animation

Usually caused by root or hips translation in the animation. Prefer in-place exports. The current viewer also grounds `Hips/Root` at runtime as a fallback.
