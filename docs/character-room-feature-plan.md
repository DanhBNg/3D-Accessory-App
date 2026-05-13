# Character Room Feature Plan

Feature 3: selected character stands in a room and plays local actions such as idle, run, jump, dance.

This feature is separate from the current accessory editor. The accessory editor can be used to create/customize a character, but this room feature should consume completed full character models first.

## Product Flow

1. User opens `Character Room` from the landing screen.
2. User selects one completed character model: male or female.
3. The selected character appears inside a room.
4. User selects an action: idle, run, jump, dance, etc.
5. The character plays that animation in place.

## Assets To Prepare

Recommended folder layout:

```text
assets/models/room/
  room_default.glb

assets/models/characters_full/
  female_full.glb
  male_full.glb
```

For animation, choose one of these approaches:

```text
Option A: animation clips embedded in each character GLB
female_full.glb includes: Idle, Run, Jump, Dance
male_full.glb includes: Idle, Run, Jump, Dance
```

```text
Option B: separate animation files
assets/models/animations/
  idle.glb
  run.glb
  jump.glb
  dance.glb
```

For the current app, Option A is simpler.

For tool choices and generation pipeline, see:

```text
docs/3d-ai-tooling-guide.md
```

## Character Requirements

Each completed character model should:

- be GLB
- be fully assembled
- include body, head, hair, outfit if needed
- face +Z
- stand at room floor origin
- have feet on ground
- have consistent height between male and female
- contain the same animation clip names
- use in-place animations, not forward-moving root motion

Required animation names:

```text
Idle
Run
Jump
Dance
```

If the source exports lowercase names, normalize them in code or rename the clips before export.

## Room Requirements

The room model should:

- be GLB
- have floor centered around origin
- be large enough for one character
- not include a character
- not include baked camera-only composition
- be lightweight enough for mobile
- use simple materials and limited texture size

Recommended room prompt:

```text
Create a cute stylized compact 3D room interior as a GLB model for a mobile avatar app. The room should have a simple floor, back wall, soft lighting style, and a small empty center area where a chibi character can stand. No character, no people, no text, no logo, no animation. Front-facing composition, floor centered at origin, mobile optimized, simple clean topology, soft rounded toy-like shapes.
```

## Technical Implementation Plan

1. Keep the current `CharacterRoomScreen` as the Flutter entry screen.
2. Add a Three.js viewer HTML for this feature, separate from `character_viewer.html`.
3. Load room GLB first.
4. Load selected character GLB.
5. Read `gltf.animations` from the character.
6. Use `THREE.AnimationMixer` to play selected clips.
7. When user changes action, call JavaScript:

```js
playAction("Run")
```

8. When user changes character, call JavaScript:

```js
setCharacter("/models/characters_full/female_full.glb")
```

## Flutter State Needed

Minimum state:

```dart
selectedCharacterId
selectedActionId
isViewerLoading
viewerError
```

Local config:

```dart
CharacterRoomCharacter(
  id: 'female',
  name: 'Female',
  viewerPath: '/models/characters_full/female_full.glb',
)

CharacterRoomAction(
  id: 'run',
  label: 'Run',
  clipName: 'Run',
)
```

## Important Decisions

Use completed male/female character GLB for this feature first. Do not depend on the accessory editor output yet. Connecting the editor output to this room feature should come later after the model format is stable.

Animations should be in-place. If run animation moves forward through root motion, the character will leave the room center. Fix that at asset level when possible.

The first version should support only two characters and four actions. Add room customization later.
