# 3D Model Prompt Guide

Tai lieu nay dung de tao GLB cho `character_3d` sao cho cac part de ghep voi nhau ngay tu dau. Huong moi cua model la:

- `body`: than nhan vat khong co dau.
- `head`: dau nhan vat da kem mat va toc.
- accessories: hat, glasses, mask, backpack, bracelet, outfit...

Ly do doi sang cach nay: AI tao toc thuong khong tach sach khoi dau. Neu co gang tao hair-only asset, model de bi dinh kem mat/dau hoac sai pivot. Vi vay he customization nen thay ca `head` thay vi thay rieng `hair`.

## Target Model Structure

Recommended folders:

```text
assets/models/
  character/
    body_*.glb
  heads/
    head_*.glb
  hats/
  glasses/
  masks/
  outfits/
  others/
```

Recommended object composition:

```text
CharacterObject
  body: headless body model
  head: head + face + hair model
  accessories:
    hat
    glasses
    mask
    backpack
    bracelet
```

Important: `head` is not an accessory-only hair model. It is a complete swappable head.

## Van De Can Giai Quyet

Model co the khong fit vi:

- body co co/neck socket khac nhau
- head co pivot khong nam o diem gan voi co
- head co scale khong khop body
- model quay sai huong
- pose body khac nhau
- accessory bi sinh kem head/body/mannequin/pedestal
- mesh hoac pivot bi lech xa origin

Neu model sai huong, sai pose, kem body/head khong dung yeu cau, hoac pivot qua lech thi nen regenerate. Chi nen chinh `position`, `rotation`, `scale` trong code khi sai lech nho.

## Quy Chuan Chung

Ap dung cho moi body, head va accessory:

- Format: GLB.
- Style: cute stylized chibi mobile game asset.
- Shape language: soft rounded toy-like shapes.
- Topology: simple clean topology, mobile optimized.
- Orientation: front facing +Z.
- Rotation: neutral rotation.
- Scale target: full assembled chibi character around 1.8 to 2.0 units tall.
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
no background, no base pedestal, no display stand, no scene, no animation, no dramatic pose, no asymmetry, no cropped mesh, no extra floating parts, no text, no logo, no weapons, no non-standard orientation, no rotated model, no lying down pose, no far-away pivot, no mesh offset far from origin
```

## Body Prompt

Use for `assets/models/character/`.

Goal: create only the headless body. The body must include neck/shoulder area for attaching a separate head model, but must not include any head, face, hair, hat, glasses, mask, or facial detail.

```text
Create ONLY one standalone 3D asset: a cute stylized chibi headless body for an avatar customization system.

The output must contain only the body mesh: torso, arms, hands, legs, feet, shoulders, and a simple clean neck attachment area. No head, no face, no eyes, no nose, no mouth, no ears, no hair, no bangs, no beard, no mustache, no hat, no glasses, no mask, no jewelry, no backpack, no extra props.

Style: cute stylized chibi mobile game body, compact small body, soft rounded toy-like shapes, simple clean topology, smooth material.

Technical: GLB format, standing neutral A-pose, symmetrical, front facing +Z, feet on ground, origin centered between feet at ground level, neutral rotation, no animation, no pedestal, no display stand, no background. The full assembled character with head should be around 1.8 to 2.0 units tall.

Attachment: include a simple neck socket or clean neck stump for placing a separate head model. Keep the neck attachment centered and easy to align.
```

Body variants:

```text
female cute stylized chibi headless body only, neutral A-pose, front facing +Z, same scale and orientation as the base body, clean centered neck attachment, no head, no face, no hair, no accessories, GLB
```

```text
male cute stylized chibi headless body only, neutral A-pose, front facing +Z, same scale and orientation as the base body, clean centered neck attachment, no head, no face, no hair, no accessories, GLB
```

## Head Prompt

Use for `assets/models/heads/`.

Goal: create a complete swappable head. This head includes face and hair, so the app can replace the entire head instead of trying to fit separate hair.

```text
Create ONLY one standalone 3D asset: a cute stylized chibi character head with hair for an avatar customization system.

The output must contain only the complete head mesh: head, face, ears if needed, and hair. No neck-down body, no torso, no shoulders, no arms, no hands, no legs, no clothing, no hat, no glasses, no mask, no jewelry, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game head, large rounded head, expressive simple face, integrated stylized hair, soft rounded toy-like shapes, simple clean topology, smooth material.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, no animation. Pivot should be near the lower center of the head at the neck attachment point. Do not place pivot far away from the head. Do not offset the mesh far from origin.

Fit target: compatible with a headless chibi body. The full assembled character should be around 1.8 to 2.0 units tall. The bottom of the head should align cleanly with a centered neck socket.
```

Head variants:

```text
Create ONLY one standalone 3D asset: cute chibi female head with short bob hair. Include head, face, ears if needed, and integrated hair only. No body, no neck-down torso, no hat, no glasses, no mask, no pedestal. Front facing +Z, centered at origin, pivot at lower center neck attachment point, GLB.
```

```text
Create ONLY one standalone 3D asset: cute chibi male head with simple stylized hair. Include head, face, ears if needed, and integrated hair only. No body, no neck-down torso, no hat, no glasses, no mask, no pedestal. Front facing +Z, centered at origin, pivot at lower center neck attachment point, GLB.
```

```text
Create ONLY one standalone 3D asset: cute chibi fantasy head with colorful integrated hair. Include head, face, ears if needed, and integrated hair only. No body, no hat, no glasses, no mask, no pedestal. Front facing +Z, centered at origin, pivot at lower center neck attachment point, GLB.
```

## Accessory Prompt Template

Use this template for accessories that remain separate from body/head.

```text
Create ONLY one standalone 3D accessory asset: [ACCESSORY_NAME].

The output must contain only the accessory mesh itself.
No character, no full head unless the accessory is a head, no face, no eyes, no nose, no ears, no body, no mannequin, no bust, no hands, no arms, no clothing unless the accessory is clothing, no display stand, no pedestal, no background, no extra props, no text, no logo.

Style: cute stylized chibi mobile game asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, pivot near the real attachment point, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a chibi character assembled from a headless body and swappable head, full height around 1.8 to 2.0 units.
```

## Hat Prompt

Use for `assets/models/hats/`.

Note: hats may clip with integrated hair. If a head already has large hair, either generate a head variant with the hat included, or use hat only for heads designed to support hats.

```text
Create ONLY one standalone 3D accessory asset: [hat name].

The output must contain only the hat mesh itself. No character, no head, no face, no hair, no body, no mannequin, no bust, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game hat asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, front facing +Z, neutral rotation, pivot near the center of the head-top attachment area, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a large chibi head around 1.8 to 2.0 full character scale. The hat should be slightly larger than the chibi head width.
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

Fit target: compatible with a large chibi head around 1.8 to 2.0 full character scale.
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

Fit target: compatible with a large chibi head around 1.8 to 2.0 full character scale. The mask should fit the lower half of a chibi face.
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

Fit target: compatible with the back of a chibi headless body around 1.8 to 2.0 assembled character scale. The backpack should sit close to the character back.
```

## Bracelet Prompt

Use for a future wrist accessory such as `assets/models/wrist/bracelet.glb`.

```text
Create ONLY one standalone 3D accessory asset: cute chibi bracelet.

The output must contain only the bracelet mesh itself. No character, no hand, no arm, no body, no mannequin, no bust, no display stand, no pedestal, no background, no extra props.

Style: cute stylized chibi mobile game bracelet asset, soft rounded toy-like shapes, simple clean topology, smooth material, mobile optimized.

Technical: GLB format, single object where possible, centered at origin, neutral rotation, pivot centered in the bracelet hole at the wrist attachment point, no animation. Do not place pivot far away from the object. Do not offset the mesh far from origin.

Fit target: compatible with a chibi character wrist, around 1.8 to 2.0 assembled character scale. The bracelet should be small and easy to place on either wrist.
```

## Recommended Generation Workflow

1. Generate one approved headless `body` first.
2. Generate one approved `head` that fits the body neck socket.
3. Use that body/head pair as reference for every later body, head and accessory.
4. Generate all body models with the same pose, scale, orientation, origin, and neck attachment height.
5. Generate all head models with pivot at the lower center neck attachment point.
6. Generate accessories as accessory-only GLB files, never merged with body/head unless the model is intentionally a complete head.
7. Import each GLB into the app.
8. Add body models to `character_object_mock_data.dart`.
9. Add head and accessory models to `accessory_mock_data.dart` or a future `head_mock_data.dart`.
10. If a part is slightly off, add a per-body/per-head transform override.
11. If the transform override is extreme, regenerate the model with a stricter prompt.

## When To Regenerate Vs. Tune In Code

Regenerate the model if:

- body includes any head, face, hair, hat, glasses, mask, or facial detail
- body does not have a clean centered neck attachment
- head includes neck-down body, shoulders, arms, clothing, mannequin, bust, pedestal, or background
- head pivot is not near the lower center neck attachment point
- accessory includes unwanted head/body/mannequin/bust/hand/arm/pedestal/background
- model faces the wrong direction
- model has a different pose from other bodies
- model is wildly oversized or undersized
- pivot is far away from the actual object
- mesh is offset far from origin

Tune in code if:

- head is slightly too high/low on the neck
- glasses are slightly forward/back on a specific head
- mask is slightly too high/low on a specific head
- hat clips slightly on a compatible head
- backpack needs a small offset
- bracelet needs a small wrist adjustment

## Code Migration Notes

Current code may still use older names such as `hair` slot or `assets/models/hair/`. For the new model strategy, migrate gradually:

```text
old: hair accessory slot
new: head slot containing head + face + hair
```

Recommended future entities:

```text
Character3DObject
  bodyModel
  defaultHeadId
  defaultAccessoryIds

HeadItem
  id
  name
  modelPath
  viewerPath
  transform overrides

AccessoryItem
  hats/glasses/masks/outfits/back/wrist
```

Body objects are currently configured in:

```text
lib/features/character_3d/data/character_object_mock_data.dart
```

Accessories are currently configured in:

```text
lib/features/character_3d/data/accessory_mock_data.dart
```

Per-body fitting can be handled with:

```dart
characterTransforms: {
  'character1': AccessoryTransform(
    position: [0, 0.93, -0.03],
    scale: [0.60, 0.60, 0.60],
  ),
}
```

This should remain a fallback. The better long-term fix is consistent source model generation with headless bodies and swappable complete heads.
