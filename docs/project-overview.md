# Project Overview

## Goal

The app is a Flutter demo with three experience areas:

1. Cinematic VFX
   - Landing screen for VFX presets.
   - Mock image-upload flow.
   - Video preview with `video_player`.

2. 3D Character Accessory
   - Shows GLB character/accessory assets in a WebView.
   - Uses Three.js in `assets/web/character_viewer.html`.
   - Uses a local HTTP asset server so HTML can load Flutter bundled assets.
   - Supports basic accessory selection and viewer controls.

3. Character Room
   - Shows a rigged character inside a room GLB.
   - Uses `assets/web/character_room_viewer.html`.
   - Loads reusable animation-only GLB files.
   - Current demo supports 3 rigged characters and 3 actions.

## Main Technologies

- Flutter
- Dart
- `video_player`
- `webview_flutter`
- Three.js inside local HTML viewers
- Local `.glb` assets

## Architecture Decision

The app is still a local demo, so it uses a clean-lite approach:

- Feature-first folders.
- `data/domain/presentation` only where it helps.
- No repository/usecase/datasource/DTO layers unless there is a real backend or API boundary.

Add fuller architecture later only when needed for:

- AI generation API.
- User inventory.
- Remote asset download.
- Login/profile.
- Payment or unlock flow.
