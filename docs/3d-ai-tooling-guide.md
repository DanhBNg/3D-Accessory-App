# 3D AI Tooling Guide

Tai lieu nay gom cac tool va pipeline nen dung de tao asset cho `Character Room`.

Muc tieu cua feature:

- `female_full.glb`
- `male_full.glb`
- `room_default.glb`
- character GLB co animation clips: `Idle`, `Run`, `Jump`, `Dance`

## Nhom Viec Can Lam

Can tach thanh 2 nhom:

1. Tao model 3D tinh.
2. Rig va animation cho character.

Room la model tinh, khong can rig/animation. Male/female character can rig va animation.

## Tool Tao Model 3D

Dung de tao:

```text
assets/models/characters_full/female_full.glb
assets/models/characters_full/male_full.glb
assets/models/room/room_default.glb
```

Recommended tools:

- Meshy AI: uu tien cho project nay vi co text/image to 3D, auto-rig, animation presets, export GLB/FBX.
- Tripo AI: tot cho text/image to 3D, auto-rig, export GLB/FBX/OBJ.
- Hunyuan 3D / Seed 3D: tot cho GLB tinh, nhung rig/animation co the can tool khac.
- Zeno3D / Dimensia: co the dung cho props/room/model tinh, khong nen uu tien cho character animation.

## Tool Rig Va Animation

Dung de cho character co:

```text
Idle
Run
Jump
Dance
```

Recommended tools:

- Meshy AI: tien nhat neu muon end-to-end. Generate/upload character, auto-rig, chon animation, export GLB/FBX.
- Mixamo: rat on cho humanoid animation. Thuong workflow la FBX, sau do dung Blender export lai GLB.
- Tripo AI Auto Rigging: auto skeleton/skin weights, export GLB/FBX/OBJ.
- AutoRig.online: rig GLB/FBX/OBJ online.
- afk.ai: rig/animate GLB/GLTF, export animated character cho game/web viewer.

## Recommended Pipeline

Pipeline de lam nhanh nhat:

```text
Meshy AI:
  create male_full / female_full
  auto-rig
  apply Idle / Run / Jump / Dance
  export GLB

Meshy AI or Tripo:
  create room_default.glb
```

Pipeline neu Meshy animation khong dung y:

```text
Meshy/Tripo:
  create static character

Mixamo:
  auto-rig
  apply Idle / Run / Jump / Dance
  export FBX

Blender:
  import FBX
  check scale/orientation
  check animation clip names
  make animation in-place if needed
  export GLB
```

## Character Export Requirements

Moi character GLB nen:

- la model humanoid ro rang
- la full character hoan chinh
- co mesh, material, rig/skeleton
- co embedded animation clips
- face forward +Z
- feet on ground
- stand near origin
- scale nam/nu tuong doi thong nhat
- animation chay tai cho, khong root motion di ra khoi vi tri

Required clip names:

```text
Idle
Run
Jump
Dance
```

Neu tool export lowercase hoac ten dai hon, nen rename trong Blender hoac map lai trong code.

## Room Export Requirements

Room GLB nen:

- la model tinh
- khong co character
- floor centered around origin
- co khoang trong giua phong de dat character
- mobile optimized
- texture/material don gian
- khong co hidden camera/light/floor thua neu khong can

Recommended room prompt:

```text
Create a cute stylized compact 3D room interior as a GLB model for a mobile avatar app. The room should have a simple floor, back wall, soft lighting style, and a small empty center area where a chibi character can stand. No character, no people, no text, no logo, no animation. Front-facing composition, floor centered at origin, mobile optimized, simple clean topology, soft rounded toy-like shapes.
```

## Practical Recommendation

Nen bat dau bang Meshy AI vi no co kha nang lam gan het pipeline trong mot cho:

```text
Text/Image to 3D
Auto rig
Animation presets
GLB export
```

Neu ket qua animation chua tot, dung Blender lam buoc cleanup cuoi cung truoc khi dua vao Flutter/Three.js.

## File Naming

Use these exact names first:

```text
assets/models/characters_full/female_full.glb
assets/models/characters_full/male_full.glb
assets/models/room/room_default.glb
```

Use these animation clip names first:

```text
Idle
Run
Jump
Dance
```

Giữ naming đơn giản giúp viewer Three.js load và switch action dễ hơn.
