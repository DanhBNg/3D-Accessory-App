# Performance Guide

This app renders 3D scenes through Three.js inside Flutter WebView. The main performance costs are GLB parsing, texture upload, per-frame animation updates, shadows, and high device pixel ratios.

## Applied Quick Wins

The room viewer currently applies these low-risk optimizations in `assets/web/character_room_viewer.html`:

- Cap WebGL pixel ratio at `1.5` instead of `2`.
- Disable Three.js shadow maps.
- Avoid `Box3.setFromObject(characterModel)` on every animation frame.
- Cache source animation clips by URL.
- Cache remapped animation clips by `characterUrl + animationUrl`.
- Only call `mixer.update(delta)` while an animation action is active.

`Box3.setFromObject` traverses the character, accessories, and skinned meshes. Running it every frame is expensive in WebView, so floor alignment should happen when loading the character or when changing animation, not during every render tick.

Animation remapping also does skeleton target lookup and creates new keyframe tracks. The room viewer caches those remapped clips per character file and animation file so switching back to a previously used action is cheaper.

## Recommended Next Steps

### Cache GLB Loads

Cache loaded GLTF files or cloned scenes in JavaScript `Map`s by URL. This avoids repeated network/local-server requests and repeated parse cost when switching characters or accessories.

Use separate caches for:

- character GLBs
- accessory GLBs
- room GLB

Animation clips are already cached in the room viewer. Character and accessory GLBs need more care because skinned models should be cloned with a skeleton-aware clone path before being added back to the scene.

### Reduce Asset Weight

Optimize GLBs before bundling:

- reduce polygon count for mobile targets
- resize textures to `512` or `1024` where possible
- merge small static meshes when material reuse is reasonable
- remove unused nodes, cameras, lights, and animations
- prefer compressed textures if the target platform supports them

### Limit Expensive Visual Features

Avoid enabling WebGL shadows by default in WebView. If shadows are needed, keep them optional and test on the lowest target device.

Also avoid very high antialiasing or pixel ratio values. A pixel ratio cap around `1.25` to `1.5` is usually a better mobile tradeoff than full device pixel ratio.

### Keep Per-Frame Work Small

Inside `requestAnimationFrame`, avoid:

- full-scene bounding box recalculation
- repeated scene traversal
- repeated material updates
- console logging
- loading or cloning assets

The render loop should usually only update the animation mixer, controls if active, and render the scene.

### Consider Native Rendering Later

If WebView performance remains a blocker after asset and runtime optimization, consider a native Flutter 3D path. This is a larger migration, but it can avoid some WebView overhead.
