# Architecture

The project uses a feature-first, clean-lite structure. It is still a local demo, so avoid adding repository/usecase/datasource layers until there is a real backend, API, inventory, or remote asset system.

## Main Structure

```text
lib/
  main.dart

  app/
    cinematic_app.dart
    app_theme.dart

  core/
    constants/
    widgets/

  features/
    cinematic_vfx/
      data/
      presentation/

    character_3d/
      data/
      domain/
      presentation/
      web/

    character_room/
      presentation/
```

## App Layer

`lib/app/` owns app-level setup:

- `cinematic_app.dart`: `MaterialApp`, routes/home, title, theme hookup.
- `app_theme.dart`: shared theme.

Keep feature logic out of this layer.

## Core Layer

`lib/core/` is for shared constants/widgets only. Do not place feature-specific viewer, asset, or animation logic here.

## Cinematic VFX

`features/cinematic_vfx/` is currently a mock UI flow:

- preset data
- landing screen
- generator screen
- video preview cards

No domain layer is needed yet.

## Character 3D

`features/character_3d/` previews rigged character GLBs and optional accessory overlays.

Important files:

```text
lib/features/character_3d/data/character_object_mock_data.dart
lib/features/character_3d/data/accessory_mock_data.dart
lib/features/character_3d/presentation/screens/character_3d_demo_screen.dart
lib/features/character_3d/web/local_3d_server.dart
assets/web/character_viewer.html
```

The WebView cannot load Flutter assets directly. The local HTTP server maps:

```text
/models/... -> assets/models/...
```

## Character Room

`features/character_room/` owns the room/action demo.

Important files:

```text
lib/features/character_room/presentation/screens/character_room_screen.dart
assets/web/character_room_viewer.html
```

The room viewer loads:

- one room GLB
- one rigged character GLB
- one animation-only GLB at a time

## When To Add More Architecture

Add fuller Clean Architecture only when needed for:

- CDN manifest or remote asset catalog
- AI generation API
- user inventory
- login/profile
- purchases/unlocks
- persistent user-created characters
