# 3D Model Prompt Guide

Tai lieu nay dung de tao lai model 3D cho `character_3d` sao cho cac body va accessory de fit voi nhau hon. Muc tieu hien tai khong phai tao model dep rieng le, ma la tao mot he model co cung quy chuan de ghep duoc trong viewer.

## Van De Can Giai Quyet

Model hien tai co the khong fit vi body duoc tao tu prompt khac nhau:

- chieu cao va ti le dau/than khac nhau
- model quay huong khac nhau
- diem goc/pivot khac nhau
- pose tay/chan khac nhau
- accessory duoc tao theo kich thuoc rieng, khong theo cung body chuan
- mot so phu kien co the da gom ca phan dau/mat, lam kho gan vao character khac

Vi vay chi chinh `position`, `rotation`, `scale` trong code la xu ly duoc cho demo, nhung cang nhieu model thi cang ton cong. Cach tot hon la chuan hoa prompt tao model.

## Quy Chuan Chung

Ap dung cho moi model body va accessory:

- Format: GLB, single object where possible.
- Style: stylized low-poly / clean 3D game asset.
- Orientation: facing forward, front view aligned to positive Z direction.
- Pose: neutral A-pose or relaxed T-pose, symmetrical.
- Scale: human character around 1.8 units tall.
- Origin/pivot: centered at ground between feet for body; centered at attachment area for accessory.
- Background: none.
- Animation: none.
- Rig: not required for current demo.
- Materials: simple PBR or flat colors, no baked background.
- Avoid: extreme proportions, tilted head, dynamic action pose, merged accessory with body.

## Negative Prompt Chung

Use this negative prompt for all generated models:

```text
no background, no base pedestal, no scene, no animation, no dramatic pose, no asymmetry, no cropped mesh, no extra floating parts, no text, no logo, no weapons, no merged full character for accessory, no oversized accessory, no non-standard orientation, no rotated model, no lying down pose
```

## Body Prompt

Use for `assets/models/character/`.

```text
Create a stylized low-poly 3D game character body as a GLB model. The character must stand upright in a neutral A-pose, facing forward, symmetrical, feet on the ground, origin centered between the feet at ground level. Use a consistent human proportion with total height around 1.8 units, head size suitable for accessories like hats, glasses, masks, and hair. Keep the head, face, torso, arms, and legs clean and simple. Do not include hair, hat, glasses, mask, backpack, jewelry, weapons, pedestal, background, animation, or scene. Export as a single clean GLB model with simple materials.
```

Prompt variants:

```text
female stylized low-poly 3D game character body, neutral A-pose, same scale and orientation as the base character, no accessories, GLB
```

```text
male stylized low-poly 3D game character body, neutral A-pose, same scale and orientation as the base character, no accessories, GLB
```

## Hair Prompt

Use for `assets/models/hair/`.

```text
Create a stylized low-poly 3D hair accessory as a separate GLB model for a standard 1.8 unit character head. The hair must be centered around the head attachment area, facing forward, symmetrical, with pivot near the center of the head. Do not include head, face, body, hat, glasses, mask, background, animation, or pedestal. The model should be easy to place on top of a character head and should not extend too far below the ears.
```

## Hat Prompt

Use for `assets/models/hats/`.

```text
Create a stylized low-poly 3D hat accessory as a separate GLB model for a standard 1.8 unit character head. The hat must face forward, be symmetrical, and have its pivot centered near the head top. Do not include head, hair, face, body, background, animation, or pedestal. The hat should fit over a standard character head and be slightly larger than the head width.
```

Prompt variants:

```text
stylized low-poly beanie hat accessory only, separate GLB model, front-facing, centered pivot, no head, no body
```

```text
stylized low-poly bucket hat accessory only, separate GLB model, front-facing, centered pivot, no head, no body
```

## Glasses Prompt

Use for `assets/models/glasses/`.

```text
Create a stylized low-poly 3D glasses accessory as a separate GLB model for a standard character face. The glasses must face forward, be symmetrical, and have the pivot centered between the lenses. Do not include head, eyes, face, body, hair, hat, mask, background, animation, or pedestal. The glasses should be sized for a standard 1.8 unit character and easy to place on the face.
```

Prompt variants:

```text
stylized cyber visor accessory only, separate GLB model, front-facing, centered, no head, no face, no body
```

```text
stylized round glasses accessory only, separate GLB model, front-facing, centered, no head, no face, no body
```

## Mask Prompt

Use for `assets/models/masks/`.

```text
Create a stylized low-poly 3D face mask accessory as a separate GLB model for a standard character face. The mask must face forward, be symmetrical, and have the pivot centered near the mouth and nose area. Do not include head, face, body, hair, hat, glasses, background, animation, or pedestal. The mask should fit the lower half of a standard character face.
```

Prompt variants:

```text
stylized low-poly medical face mask accessory only, separate GLB model, front-facing, centered, no head, no body
```

```text
stylized low-poly ninja face mask accessory only, separate GLB model, front-facing, centered, no head, no body
```

## Backpack Prompt

Use for `assets/models/others/mini_backpack.glb` or move later to `assets/models/back/`.

```text
Create a stylized low-poly 3D mini backpack accessory as a separate GLB model for the back of a standard 1.8 unit character. The backpack must face backward relative to the character, be symmetrical, and have the pivot centered on the attachment point on the upper back. Do not include body, arms, head, straps merged with a character, background, animation, or pedestal. The backpack should sit close to the character's back.
```

## Bracelet Prompt

Use for `assets/models/others/bracelet.glb` or move later to `assets/models/wrist/`.

```text
Create a stylized low-poly 3D bracelet accessory as a separate GLB model for a standard character wrist. The bracelet must be centered around the wrist attachment point, with a clean circular shape and simple material. Do not include hand, arm, body, background, animation, or pedestal. The bracelet should be small and easy to place on either wrist.
```

## Recommended Generation Workflow

1. Generate one approved `base_character` first.
2. Use that body as the visual reference for every later body and accessory.
3. Generate all new body models with the same pose, scale, orientation, and origin.
4. Generate accessories as accessory-only GLB files, never merged with a character.
5. Import each GLB into the app.
6. Add it to `accessory_mock_data.dart` or `character_object_mock_data.dart`.
7. If it does not fit every body, add a `characterTransforms` override for that body.
8. If the transform override is extreme, regenerate the model with a stricter prompt instead of forcing it in code.

## When To Regenerate Vs. Tune In Code

Regenerate the model if:

- it faces the wrong direction
- it has a different pose from other bodies
- it includes a pedestal, scene, or background mesh
- accessory includes head/body geometry
- model is wildly oversized or undersized
- pivot is far away from the actual object

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
