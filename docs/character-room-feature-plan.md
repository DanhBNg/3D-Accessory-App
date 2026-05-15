# Character Room Feature Plan

The Character Room feature shows a completed rigged character inside a room and applies reusable animation-only GLB files.

This feature is separate from the accessory editor. It should consume completed rigged character models first.

## Current Product Flow

1. User opens `Character Room` from the landing screen.
2. User selects a rigged character.
3. The selected character appears inside `room_default.glb`.
4. User selects an action.
5. The viewer loads the animation-only GLB and applies the clip to the current character.
6. The room remains fixed while the user drags horizontally to rotate only the character.
7. The character remains grounded at character floor offset `0.48`; the room floor remains at `0`.

## Current Demo Assets

```text
assets/models/room/
  room_default.glb

assets/models/characters_rigged/
  character_1.glb
  character_2.glb
  character_3.glb

assets/models/animations/
  breathing_idle.glb
  jumping_down.glb
  spin_act.glb
  hip_hop_dancing.glb
```

## Current Implementation

Flutter screen:

```text
lib/features/character_room/presentation/screens/character_room_screen.dart
```

Three.js viewer:

```text
assets/web/character_room_viewer.html
```

The screen calls JavaScript:

```js
setCharacter("character1")
playExternalAnimation("/models/animations/jumping_down.glb")
```

The viewer maps:

```js
const CHARACTER_URLS = {
  character1: "/models/characters_rigged/character_1.glb",
  character2: "/models/characters_rigged/character_2.glb",
  character3: "/models/characters_rigged/character_3.glb"
};
```

## Character Requirements

Each room character should:

- be GLB
- be a complete humanoid character
- include mesh
- include skeleton/bones
- include skin weights
- include materials/textures if color is required
- use a Mixamo-compatible skeleton
- stand near the origin
- have feet on the ground before export
- be optimized enough for mobile

The current viewer supports common Mixamo bone naming variants:

```text
mixamorigHips
mixamorig_Hips
```

## Animation Requirements

Each reusable animation should:

- be GLB
- contain at least one animation clip
- usually contain no mesh
- target the same Mixamo-compatible skeleton as the characters
- be in-place when possible

Current actions:

```text
Idle         -> assets/models/animations/breathing_idle.glb
Jumping Down -> assets/models/animations/jumping_down.glb
Spin         -> assets/models/animations/spin_act.glb
Hip Hop      -> assets/models/animations/hip_hop_dancing.glb
```

If an animation includes vertical root or hips movement, the viewer clones the clip and grounds the `Hips/Root` position track so the character does not float above the room.

## Room Requirements

The room model should:

- be GLB
- have a usable floor near the expected character placement
- have enough empty space for one character
- not include a character
- be lightweight for mobile
- use simple materials and limited texture size

Current floor offsets used by the viewer:

```js
const CHARACTER_FLOOR_OFFSET = 0.48;
const ROOM_FLOOR_Y = 0;
```

The room uses disabled `OrbitControls`; horizontal pointer drag changes `characterModel.rotation.y` only.

## Technical Notes

- The room viewer uses `THREE.AnimationMixer`.
- Characters and animations are separate assets.
- Animation tracks are remapped when the only difference is `mixamorig` vs `mixamorig_`.
- The viewer checks missing animation targets before playing.
- The local asset server maps `/models/...` to `assets/models/...`.

## Next Steps

- Keep `breathing_idle.glb` as the default animation when entering the room or switching characters.
- Replace test characters with final optimized characters.
- Use in-place Mixamo exports where available.
- Move large GLBs to Git LFS if the repo keeps storing binary assets.
- Add a third character only after the two-character shared animation flow is stable.
