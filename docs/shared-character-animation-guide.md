# Shared Character Animation Guide

This guide explains how to set up a simple demo with multiple characters and reusable animations, where each character can use the same animation files.

The key idea: characters and animations must be separate assets, but they must use the same skeleton standard.

## Goal

The target setup is:

```text
Character A + Animation 1
Character A + Animation 2
Character B + Animation 1
Character B + Animation 2
```

That only works reliably when Character A and Character B are both rigged to the same skeleton.

## Important Terms

### Mesh

The visible body or object. This is the part you can see: face, body, clothes, hair, shoes.

### Skeleton / Armature / Bones

The hidden bone structure inside the character. Animation clips move these bones.

Example Mixamo bone names:

```text
mixamorig_Hips
mixamorig_Spine
mixamorig_LeftArm
mixamorig_RightArm
mixamorig_LeftLeg
mixamorig_RightLeg
```

### Skin Weights

The data that connects the mesh to the skeleton.

Example: the left arm mesh follows the `mixamorig_LeftArm` and `mixamorig_LeftForeArm` bones.

If a character has no skin weights, the skeleton cannot move the mesh.

### Animation Clip

A set of keyframes that moves bones over time.

Example:

```text
mixamorig_Hips.position
mixamorig_LeftArm.rotation
mixamorig_RightLeg.rotation
```

An animation clip does not magically move any character. It only moves matching bones.

## Why The Current Demo Feels Fixed

Earlier temporary tests used a dance animation GLB as both:

```text
1. the character model
2. the dance animation
```

That works for one demo model, but it is fixed to that asset.

The better setup is:

```text
characters/character_1.glb
characters/character_2.glb
characters/character_3.glb

animations/jumping_down.glb
animations/spin_act.glb
animations/hip_hop_dancing.glb
animations/breathing_idle.glb
```

Then the app loads:

```text
current character GLB
current animation GLB
```

The same animation can be applied to any loaded character that has the same skeleton.

## Correct Asset Structure

Use a structure like this:

```text
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

Each character file should contain:

```text
mesh
skeleton
skin weights
```

Each animation file should contain:

```text
skeleton-compatible animation clip
```

It is okay if animation files also contain a temporary mesh from the source tool, but the app should only use the animation clip from them.

## Required Rule

All characters must share the same skeleton standard.

For a simple demo, use Mixamo for everything:

```text
character_1.glb -> Mixamo rig -> mixamorig_* bones
character_2.glb -> Mixamo rig -> mixamorig_* bones
character_3.glb -> Mixamo rig -> mixamorig_* bones
breathing_idle.glb -> Mixamo animation -> mixamorig_* bones
jumping_down.glb -> Mixamo animation -> mixamorig_* bones
spin_act.glb -> Mixamo animation -> mixamorig_* bones
hip_hop_dancing.glb -> Mixamo animation -> mixamorig_* bones
```

If one character uses `mixamorig_LeftArm` and another uses `LeftArmature_Arm_L`, the same animation will not apply directly.

## Demo Plan: 2 Characters, 2 Animations

For the first clean demo, prepare these 4 files:

```text
assets/models/characters_rigged/character_1.glb
assets/models/characters_rigged/character_2.glb
assets/models/characters_rigged/character_3.glb
assets/models/animations/breathing_idle.glb
assets/models/animations/jumping_down.glb
assets/models/animations/spin_act.glb
assets/models/animations/hip_hop_dancing.glb
```

Both character files must have:

```text
skins: at least 1
nodes: includes Mixamo bones
animations: optional
```

Both animation files must have:

```text
animations: at least 1
animation tracks target Mixamo bones
```

## How To Prepare The Files

### Option A: Mixamo Workflow

Use this for the simplest demo.

1. Export or download a character as `.fbx`, `.obj`, `.glb`, or `.gltf`.
2. Upload the character to Mixamo.
3. Let Mixamo auto-rig the character.
4. Download the rigged character.
5. Repeat for the second character.
6. Download `Idle` animation from Mixamo using the same skeleton style.
7. Download `Hip Hop Dancing` animation from Mixamo using the same skeleton style.
8. Convert all files to `.glb` using Blender if needed.

Recommended Blender export:

```text
File > Export > glTF 2.0
Format: glTF Binary (.glb)
Include: Selected Objects
Transform: +Y Up if needed
Data: Mesh, Skinning
Animation: enabled for animation files
```

### Option B: Blender Retarget Workflow

Use this only if the characters come from different sources and already have different skeletons.

1. Import character into Blender.
2. Import Mixamo animation.
3. Retarget the animation to the character skeleton.
4. Bake the animation.
5. Export character and/or animation as GLB.

This is more flexible, but slower and easier to break. For the demo, prefer Option A.

## How To Check A GLB

A character GLB should not be just one mesh node.

Good character GLB:

```text
Has skins: yes
Has bones: yes
Has mesh: yes
```

Bad character GLB for animation:

```text
Has skins: no
Has bones: no
Has mesh: yes
```

Any GLB with mesh only, and no skins/bones, is in the bad category for shared animation.

## How The App Should Work

The viewer should keep two separate concepts:

```js
const CHARACTERS = {
  character1: '/models/characters_rigged/character_1.glb',
  character2: '/models/characters_rigged/character_2.glb',
  character3: '/models/characters_rigged/character_3.glb'
};

const ANIMATIONS = {
  idle: '/models/animations/breathing_idle.glb',
  jumpingDown: '/models/animations/jumping_down.glb',
  spin: '/models/animations/spin_act.glb',
  hipHop: '/models/animations/hip_hop_dancing.glb'
};
```

When selecting a character:

```js
loadCharacter(CHARACTERS.character1);
```

When selecting an animation:

```js
playAnimation(ANIMATIONS.jumpingDown);
```

Do not use the dance GLB as the character model unless it is only a temporary test.

## Common Problems

### Character loses color after Mixamo

Cause:

```text
the rigged/exported GLB has no embedded textures or material colors
```

This is common when the model goes through Mixamo as FBX. Mixamo focuses on rigging and animation. Depending on the source model and export settings, textures may not be embedded in the downloaded file.

How to confirm:

```text
Materials: yes
Textures: 0
Images: 0
```

If textures and images are `0`, the app cannot recover the original colors. The colors are not in the file.

Fix workflow:

```text
1. Keep the original downloaded model folder with textures.
2. Upload the character mesh to Mixamo and download the rigged FBX With Skin.
3. Open Blender.
4. Import the rigged FBX from Mixamo.
5. Reconnect the original texture images to the character materials.
6. Export as GLB with textures embedded.
```

Recommended Blender export settings:

```text
File > Export > glTF 2.0
Format: glTF Binary (.glb)
Include: Selected Objects
Data: Mesh, Skinning
Materials: Export
Images: Automatic or JPEG/PNG
Animation: optional for character files
```

For the reusable-animation setup, the character file should contain:

```text
mesh
skeleton
skin weights
materials
textures/images
```

The animation-only file can stay textureless because it only provides motion.

### Character does not move

Cause:

```text
character has no skeleton/skin
```

Fix:

```text
use a rigged character GLB
```

### Character moves incorrectly

Cause:

```text
character skeleton does not match animation skeleton
```

Fix:

```text
use the same skeleton standard for all characters and animations
```

### Character jumps into the air

Cause:

```text
animation includes root or hips vertical translation
```

Fix options:

```text
clean the animation in Blender
remove/lock root Y translation in code
export an in-place animation
```

For app demos, prefer an in-place animation. In Mixamo this is often called "In Place".

### File from Sketchfab has many files

That is normal.

Common download formats:

```text
model.gltf
model.bin
textures/*.png
textures/*.jpg
```

This is the unpacked version of a model. Import it into Blender and export as one `.glb` file.

## Recommended First Milestone

Do not try to support every possible downloaded model yet.

First milestone:

```text
3 rigged Mixamo characters
3 Mixamo animations
all exported as GLB
all using mixamorig_* bones
```

After that works, the app can be improved to support more models.

## Checklist Before Adding A Character

Before adding a new character to the app, confirm:

```text
[ ] File is .glb
[ ] Character has mesh
[ ] Character has skeleton/bones
[ ] Character has skin weights
[ ] Bone names match the animation skeleton
[ ] Character stands correctly at rest pose
[ ] File size is acceptable for mobile
```

## Checklist Before Adding An Animation

Before adding a new animation:

```text
[ ] File is .glb
[ ] File has at least one animation clip
[ ] Animation tracks target the same skeleton as the characters
[ ] Animation is in-place if it should not move around the room
[ ] Root/Hips vertical movement is acceptable
```

## Short Summary

To make "any character can use the same dance":

```text
Different meshes are okay.
Different skeletons are not okay for a simple demo.
All characters need the same rig.
Animations target that shared rig.
```

For now, build the demo around:

```text
3 characters with Mixamo rig
3 animations from Mixamo
```

That is the cleanest path to make the dance reusable instead of fixed to one model.
