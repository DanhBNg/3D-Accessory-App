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
    hats/
    glasses/
    masks/
    others/

  thumbnails/
    hair/
    hats/
    glasses/
    masks/
```

## Current Bundle Strategy

`pubspec.yaml` currently bundles local assets. This is convenient for offline demos but makes APKs large.

Keep only directories that actually contain files. Empty asset directories can break future builds if the placeholder file is removed.

## Lightest APK Strategy

For the smallest APK, move large GLBs to CDN:

```text
CDN:
  models/characters_rigged/*.glb
  models/animations/*.glb
  models/room/*.glb
  models/hair|hats|glasses|masks|others/*.glb

APK:
  assets/web/
  small config JSON if needed
```

Then remove large asset folders from `pubspec.yaml`.

Recommended CDN requirements:

- public HTTPS URLs
- CORS enabled for `GET` and `HEAD`
- stable paths matching the app config
- cache headers for large immutable GLBs

Example CDN URL:

```text
https://cdn.example.com/models/characters_rigged/character_1.glb
```

## Local WebView Asset Loading

When assets are bundled locally, HTML uses local server paths:

```text
HTML URL:    /models/characters_rigged/character_1.glb
Flutter map: assets/models/characters_rigged/character_1.glb
```

This mapping lives in:

```text
lib/features/character_3d/web/local_3d_server.dart
```

## Adding A Rigged Character

1. Add the GLB:

```text
assets/models/characters_rigged/character_4.glb
```

2. Confirm it has:

```text
mesh
skeleton/bones
skin weights
materials/textures if color matters
```

3. Add it to the relevant config:

- `character_3d`: `character_object_mock_data.dart`
- `character_room`: `CHARACTER_URLS` in `character_room_viewer.html` and chips in `CharacterRoomScreen`

## Adding An Animation

1. Add animation-only GLB:

```text
assets/models/animations/new_action.glb
```

2. Confirm it has:

```text
animations: at least 1
meshes: usually 0
tracks target Mixamo-compatible bones
```

3. Add a chip in:

```text
lib/features/character_room/presentation/screens/character_room_screen.dart
```

Prefer in-place Mixamo exports. The room viewer also grounds `Hips/Root` as a fallback.

## Size Notes

- Git LFS helps repository health, but it does not reduce APK size.
- CDN or lazy download is the main path to a small APK.
- Texture size and mesh complexity are the main GLB size drivers.
