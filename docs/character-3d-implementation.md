# 3D Character Implementation Notes

## Flow

1. Flutter opens `Character3DDemoScreen`.
2. The screen starts `Local3DAssetServer`.
3. The local server binds to `127.0.0.1` with a random port.
4. WebView loads `http://127.0.0.1:{port}/character_viewer.html`.
5. Flutter sends a JSON character config to the HTML viewer.
6. The HTML viewer loads GLB files through local `/models/...` URLs.

Current body models for this feature:

```text
/models/characters_rigged/character_1.glb
/models/characters_rigged/character_2.glb
/models/characters_rigged/character_3.glb
```

## Important Files

- Flutter screen:
  - `lib/features/character_3d/presentation/screens/character_3d_demo_screen.dart`
- Character config:
  - `lib/features/character_3d/data/character_object_mock_data.dart`
- Accessory config:
  - `lib/features/character_3d/data/accessory_mock_data.dart`
- Local server:
  - `lib/features/character_3d/web/local_3d_server.dart`
- HTML viewer:
  - `assets/web/character_viewer.html`

## JavaScript API

The HTML viewer exposes:

```js
setCharacterObject(characterObject)
setAccessory(config)
setPartVisible(partName, visible)
rotateCharacter(deltaY)
resetView()
```

Flutter calls these through:

```dart
_controller.runJavaScript(...);
```

## Current Notes

- Feature 2 now uses the same rigged character files as the room demo.
- Old unrigged body files are no longer referenced by this feature.
- Character switching is guarded with a load token so a stale async GLB load cannot add an old body back into the scene after the user switches character.
- Accessories are still standalone GLB overlays. Their default transforms may not fit every rigged character yet.

## Next Improvements

- Add per-rigged-character accessory transforms if accessory fitting remains part of the demo.
- Hide or simplify accessory controls if the feature should become a rigged character preview only.
- Optimize the large rigged GLB files for mobile APK size.
