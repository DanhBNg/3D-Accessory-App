# Asset Guide

## Current Asset Layout

```text
assets/
  web/
    character_viewer.html
    character_room_viewer.html

  models/
    characters_rigged/
      character_1.glb
      character_2.glb
      character_3.glb

    animations/
      breathing_idle.glb
      jumping_down.glb
      spin_act.glb
      hip_hop_dancing.glb

    room/
      room_default.glb

    hair/
      hair_style_1.glb

    hats/
      bucket_hat.glb
      hat_style_1.glb

    glasses/
    masks/
    outfits/
    others/

  thumbnails/
    hair/
    hats/
    glasses/
    masks/
    outfits/
```

## Current `pubspec.yaml` Strategy

Use explicit files for large model folders when possible.

Current important entries:

```yaml
flutter:
  assets:
    - assets/web/
    - assets/models/characters_rigged/
    - assets/models/room/
    - assets/models/animations/
```

Avoid adding an entire directory if it contains unused heavy files such as `.model`, source exports, or old test GLBs.

## Local WebView Asset Loading

The HTML viewers cannot load Flutter asset paths directly.

The app uses `Local3DAssetServer`:

```text
HTML URL:    /models/characters_rigged/character_1.glb
Flutter map: assets/models/characters_rigged/character_1.glb
```

Any file under `/models/...` is mapped to `assets/models/...` by the local HTTP server.

## Adding A Rigged Character For The Room

1. Add the GLB:

```text
assets/models/characters_rigged/character_3.glb
```

2. Confirm it has:

```text
mesh
skeleton/bones
skin weights
materials/textures if color is needed
```

3. Add it to `CHARACTER_URLS` in:

```text
assets/web/character_room_viewer.html
```

4. Add a matching chip in:

```text
lib/features/character_room/presentation/screens/character_room_screen.dart
```

## Adding An Animation For The Room

1. Add the animation-only GLB:

```text
assets/models/animations/new_action.glb
```

2. Confirm it has:

```text
animations: at least 1
meshes: usually 0 for animation-only
tracks target Mixamo bones
```

3. Add an action chip in:

```text
lib/features/character_room/presentation/screens/character_room_screen.dart
```

4. Prefer in-place animation exports. If the animation moves vertically, the viewer currently tries to ground `Hips/Root` at the room floor offset.

## Adding An Accessory

1. Add the model:

```text
assets/models/hair/hair_style_2.glb
```

2. Add thumbnail if available:

```text
assets/thumbnails/hair/hair_style_2.png
```

3. Add the item to:

```text
lib/features/character_3d/data/accessory_mock_data.dart
```

4. If the HTML viewer needs a new model path, use `/models/...` URLs.

## Size Notes

- Current rigged characters are large enough for GitHub to warn near or above 50 MB.
- Use Git LFS if these files stay in the repository.
- Remove unused GLBs from both `assets/models/` and `pubspec.yaml`.
- Compress textures before GLB export for mobile APK size.
