# Roadmap

## Done

- Cinematic VFX mock flow.
- Local Three.js WebView viewer.
- Rigged character room demo.
- Reusable animation-only GLBs.
- Three rigged characters in both character preview and room demo.
- Room viewer:
  - room scaled up
  - camera/room fixed
  - horizontal drag rotates only the character
  - `breathing_idle.glb` is default entry animation

## Current Priority

Reduce APK size.

Recommended direction:

1. Move large `.glb` files to CDN.
2. Keep only `assets/web/` and small config/fallback assets bundled.
3. Add a CDN base URL/config layer.
4. Optionally add local cache after first download.

## Next Engineering Tasks

- Replace hard-coded local model paths with configurable asset base URL.
- Support local/CDN switching for development.
- Add basic loading/error states for remote GLB downloads.
- Decide whether accessories stay in feature 2 or are hidden for a simpler rigged-character demo.
- Use Git LFS for large GLB files if they remain in the repository.

## Later

- Optimize GLBs: texture compression, lower poly count, smaller maps.
- Add remote asset manifest.
- Add user inventory or generated asset history only if backend work starts.
- Add full Clean Architecture layers only when backend/API boundaries exist.
