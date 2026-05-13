# 3D Model Prompt Guide

Tai lieu nay dung de tao GLB cho `character_3d` sao cho body va accessory de fit voi nhau ngay tu dau. Muc tieu khong phai tao tung model dep rieng le, ma la tao mot he model co cung scale, pose, huong, pivot va style.

## Van De Can Giai Quyet

Model hien tai co the khong fit vi body/accessory duoc tao tu prompt khac nhau:

- body co ti le dau/than khac nhau
- body co huong quay khac nhau
- pose khac nhau
- mesh/pivot bi lech xa origin
- accessory bi sinh kem dau, mat, tay, body, mannequin hoac pedestal
- accessory fit body nay nhung khong fit body khac

Neu model sai huong, sai pose, kem body/head, hoac pivot qua lech thi nen regenerate model. Chi nen chinh `position`, `rotation`, `scale` trong code khi sai lech nho.

## Quy Chuan Chung

Ap dung cho moi body va accessory:

- Format: GLB.
- Style: cute stylized chibi mobile game asset.
- Shape language: soft rounded toy-like shapes.
- Topology: simple clean topology, mobile optimized.
- Orientation: front facing +Z.
- Rotation: neutral rotation.
- Scale target: chibi character around 1.8 to 2.0 units tall.
- Proportions: large head, compact small body.
- Origin: object centered near origin.
- Pivot: near the real attachment point.
- Animation: none.
- Background: none.
- Pedestal/display stand: none.
- Text/logo: none.

Important technical constraints:

```text
Do not place pivot far away from the object.
Do not offset the mesh far from origin.
Do not include hidden scene objects, camera, lights, pedestal, floor, or background mesh.
```

## Negative Prompt Chung

Use this negative prompt for all generated models:

```text
no background, no base pedestal, no display stand, no scene, no animation, no dramatic pose, no asymmetry, no cropped mesh, no extra floating parts, no text, no logo, no weapons, no merged full character for accessory, no oversized accessory, no non-standard orientation, no rotated model, no lying down pose, no far-away pivot, no mesh offset far from origin
```

## Body Prompt

Use for `assets/models/character/`.

```text
Create a cute stylized chibi full-body base character as a GLB model for an avatar customization system.

The character must be completely bald, with a clean smooth head surface for attaching separate hair accessories. No hair, no bangs, no scalp hair, no beard, no mustache, no hat, no glasses, no mask, no jewelry, no backpack, no extra props.

Style: cute stylized chibi mobile game character, large head, compact small body, soft rounded toy-like shapes, simple clean topology, smooth material.

Technical: standing neutral A-pose, symmetrical, front facing +Z, feet on ground, origin centered between feet at ground level, total height around 1.8 to 2.0 units, neutral rotation, no animation, no pedestal, no display stand, no background, export as GLB.
```

Body variants:

```text
female cute stylized chibi full-body base character, completely bald smooth head, neutral A-pose, front facing +Z, same scale and orientation as the base character, no accessories, GLB
```

```text
male cute stylized chibi full-body base character, completely bald smooth head, neutral A-pose, front facing +Z, same scale and orientation as the base character, no accessories, GLB
```

## Accessory Prompt Template

Use this template for all accessories before adding item-specific details.

```text
Create ONLY one standalone 3D accessory asset: [ACCESSORY_NAME].

The output must contain only the accessory mesh itself.
No character, no head, no face, no eyes, no nose, no ears, no body, no mannequin, no bust, no hands, no arms, no hair, no clothing unless the accessory is clothing, no display stand, no pedestal, no background, no extra props, no text, no logo.

Style: cute stylized chibi mobile game asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, pivot near the real attachment point, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a chibi character around 1.8 to 2.0 units tall, large head and compact body proportions.
```

## Hair Prompt

Use for `assets/models/hair/`.

```text
Create ONLY one standalone 3D accessory asset: chibi hair.

The output must contain only the hair mesh itself. No character, no head, no face, no eyes, no ears, no body, no mannequin, no bust, no hat, no glasses, no mask, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game hair asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, pivot near the center/top of the head attachment area, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a bald chibi character around 1.8 to 2.0 units tall, large head and compact body proportions. The hair should sit on top of the head and should not extend too far below the ears.
```

## Hat Prompt

Use for `assets/models/hats/`.

```text
Create ONLY one standalone 3D accessory asset: [hat name].

The output must contain only the hat mesh itself. No character, no head, no face, no hair, no body, no mannequin, no bust, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game hat asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, pivot near the center of the head-top attachment area, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a chibi character around 1.8 to 2.0 units tall, large head and compact body proportions. The hat should fit over a bald chibi head and be slightly larger than head width.
```

Hat variants:

```text
Create ONLY one standalone 3D accessory asset: cute chibi beanie hat. The output must contain only the beanie hat mesh itself. No head, no hair, no body, no mannequin, no pedestal. Front facing +Z, centered at origin, pivot near head-top attachment point, GLB.
```

```text
Create ONLY one standalone 3D accessory asset: cute chibi bucket hat. The output must contain only the bucket hat mesh itself. No head, no hair, no body, no mannequin, no pedestal. Front facing +Z, centered at origin, pivot near head-top attachment point, GLB.
```

## Glasses Prompt

Use for `assets/models/glasses/`.

```text
Create ONLY one standalone 3D accessory asset: [glasses name].

The output must contain only the glasses mesh itself. No character, no head, no face, no eyes, no nose, no ears, no body, no mannequin, no bust, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game glasses asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, pivot centered between the lenses, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a chibi character around 1.8 to 2.0 units tall, large head and compact body proportions.
```

Glasses variants:

```text
Create ONLY one standalone 3D accessory asset: cute chibi cyber visor. The output must contain only the visor mesh itself. No head, no face, no eyes, no body, no mannequin, no pedestal. Front facing +Z, centered at origin, pivot centered between the lenses, GLB.
```

```text
Create ONLY one standalone 3D accessory asset: cute chibi round glasses. The output must contain only the glasses mesh itself. No head, no face, no eyes, no body, no mannequin, no pedestal. Front facing +Z, centered at origin, pivot centered between the lenses, GLB.
```

## Mask Prompt

Use for `assets/models/masks/`.

```text
Create ONLY one standalone 3D accessory asset: [mask name].

The output must contain only the mask mesh itself. No character, no head, no face, no eyes, no nose, no ears, no body, no mannequin, no bust, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game face mask asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, pivot centered near the mouth and nose attachment area, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a chibi character around 1.8 to 2.0 units tall, large head and compact body proportions. The mask should fit the lower half of a chibi face.
```

Mask variants:

```text
Create ONLY one standalone 3D accessory asset: cute chibi medical face mask. The output must contain only the mask mesh itself. No head, no face, no body, no mannequin, no pedestal. Front facing +Z, centered at origin, pivot near mouth and nose attachment area, GLB.
```

```text
Create ONLY one standalone 3D accessory asset: cute chibi ninja face mask. The output must contain only the mask mesh itself. No head, no face, no body, no mannequin, no pedestal. Front facing +Z, centered at origin, pivot near mouth and nose attachment area, GLB.
```

## Backpack Prompt

Use for `assets/models/others/mini_backpack.glb` or move later to `assets/models/back/`.

```text
Create ONLY one standalone 3D accessory asset: cute chibi mini backpack.

The output must contain only the backpack mesh itself. No character, no body, no arms, no hands, no head, no mannequin, no bust, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game backpack asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, neutral rotation, pivot centered on the upper-back attachment point, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with the back of a chibi character around 1.8 to 2.0 units tall, large head and compact body proportions. The backpack should sit close to the character back.
```

## Bracelet Prompt

Use for `assets/models/others/bracelet.glb` or move later to `assets/models/wrist/`.

```text
Create ONLY one standalone 3D accessory asset: cute chibi bracelet.

The output must contain only the bracelet mesh itself. No character, no hand, no arm, no body, no mannequin, no bust, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game bracelet asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, neutral rotation, pivot centered in the bracelet hole at the wrist attachment point, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a chibi character wrist, around 1.8 to 2.0 units tall character scale. The bracelet should be small and easy to place on either wrist.
```

## Recommended Generation Workflow

1. Generate one approved bald `base_character` first.
2. Use that body as the visual reference for every later body and accessory.
3. Generate all new body models with the same pose, scale, orientation, origin, and bald smooth head.
4. Generate accessories as accessory-only GLB files, never merged with a character/head/body.
5. Import each GLB into the app.
6. Add body models to `character_object_mock_data.dart`.
7. Add accessories to `accessory_mock_data.dart`.
8. If the accessory is slightly off, add a `characterTransforms` override for that body.
9. If the transform override is extreme, regenerate the model with a stricter prompt.

## When To Regenerate Vs. Tune In Code

Regenerate the model if:

- body is not bald
- body includes hair, beard, hat, glasses, mask, backpack, or jewelry
- accessory includes head, face, body, mannequin, bust, hand, arm, pedestal, or background
- model faces the wrong direction
- model has a different pose from other bodies
- model is wildly oversized or undersized
- pivot is far away from the actual object
- mesh is offset far from origin

Tune in `accessory_mock_data.dart` if:

- position is slightly too high/low
- glasses are slightly forward/back
- hat is slightly too large/small
- backpack needs a small offset
- bracelet needs a small wrist adjustment

## Current Code Mapping

Body objects are configured in:

```text
lib/features/character_3d/data/character_object_mock_data.dart
```

Accessories are configured in:

```text
lib/features/character_3d/data/accessory_mock_data.dart
```

Per-body fitting is handled with:

```dart
characterTransforms: {
  'female_body_1': AccessoryTransform(
    position: [0, 0.93, -0.03],
    scale: [0.60, 0.60, 0.60],
  ),
}
```

This should remain a fallback. The better long-term fix is consistent source model generation.
