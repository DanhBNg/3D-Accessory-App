# 3D Model Prompt Guide

Use this only when generating new 3D source assets. The current app path is full rigged humanoid characters plus reusable animation-only GLBs.

## Full Character Prompt

Use this when generating a character that will later be rigged in Mixamo.

```text
Create one complete stylized humanoid 3D character for a mobile avatar demo.

The model should be a full body character with head, torso, arms, hands, legs, feet, clothing, face, and hair. It should be suitable for Mixamo auto-rigging.

Style: cute stylized mobile game character, clean readable shape, soft rounded forms, simple materials, mobile optimized.

Technical requirements:
- GLB or FBX compatible source
- one complete humanoid character
- standing neutral A-pose or T-pose
- symmetrical pose
- feet on ground
- front facing +Z
- centered near origin
- no animation
- no weapon
- no pedestal
- no floor
- no background
- no extra scene props
- no camera or lights
- clean mesh with no floating body parts

The character should be easy to auto-rig and should not have clothing or hair intersecting the arms too heavily.
```

Negative prompt:

```text
no background, no base pedestal, no display stand, no scene, no animation, no dramatic pose, no asymmetry, no cropped mesh, no extra floating parts, no text, no logo, no weapons, no non-standard orientation, no rotated model, no lying down pose, no far-away pivot, no mesh offset far from origin
```

## Room Prompt

Use this for the room GLB.

```text
Create a cute stylized compact 3D room interior as a GLB model for a mobile avatar app.

The room should have a simple floor, back wall, soft lighting style, and enough empty center space for one character to stand. No character, no people, no text, no logo, no animation.

Style: mobile game room, soft rounded toy-like shapes, clean simple materials.

Technical requirements:
- GLB
- static model
- floor centered near origin
- front-facing composition
- mobile optimized
- simple topology
- no baked character
- no camera-only composition
```

## Optional Accessory Prompt

Use only if the accessory overlay feature remains part of the demo.

```text
Create one standalone 3D accessory asset for a stylized mobile avatar.

The output must contain only the accessory mesh itself. No character, no head, no body, no mannequin, no pedestal, no background, no extra props.

Style: cute stylized mobile game accessory, soft rounded shapes, simple clean topology, smooth material.

Technical requirements:
- GLB
- centered near origin
- front facing +Z when relevant
- neutral rotation
- pivot near the real attachment point
- no animation
- no hidden scene objects
```

Examples:

```text
hat
glasses
mask
backpack
```

## Export Notes

For characters:

```text
Generate/source model -> Mixamo rig -> Blender cleanup -> GLB export
```

For animations:

```text
Mixamo animation download with Skin: Without Skin -> Blender -> animation-only GLB
```

For mobile size:

```text
use smaller textures
reduce poly count
remove hidden meshes
avoid unused embedded animations
prefer CDN for large GLBs
```
