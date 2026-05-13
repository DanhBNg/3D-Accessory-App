# Quản Lý Assets

## Cấu Trúc Assets

```text
assets/
  web/
    character_viewer.html

  models/
    character/
      base_character.glb
      base_character.model
    hair/
      hair_style_1.glb
      hair_style_1.model
    hats/
      hat_style_1.glb
      hat_style_1.model
    glasses/
    masks/
    outfits/

  thumbnails/
    hair/
    hats/
    glasses/
    masks/
    outfits/
```

## `pubspec.yaml`

Asset đang được khai báo theo category:

```yaml
flutter:
  assets:
    - assets/web/
    - assets/models/character/
    - assets/models/hair/
    - assets/models/hats/
    - assets/models/glasses/
    - assets/models/masks/
    - assets/models/outfits/
    - assets/thumbnails/hair/
    - assets/thumbnails/hats/
    - assets/thumbnails/glasses/
    - assets/thumbnails/masks/
    - assets/thumbnails/outfits/
```

## Khi Thêm Accessory Mới

Ví dụ thêm tóc mới:

1. Thêm file:

```text
assets/models/hair/hair_style_2.glb
assets/thumbnails/hair/hair_style_2.png
```

2. Thêm item vào:

```text
lib/features/character_3d/data/accessory_mock_data.dart
```

3. Nếu viewer HTML vẫn hard-code model, thêm config vào:

```text
assets/web/character_viewer.html
```

4. Thêm route path vào:

```text
lib/features/character_3d/web/local_3d_server.dart
```

## Lưu Ý

- WebView không đọc trực tiếp Flutter asset path như widget Flutter thông thường.
- Vì vậy app dùng local HTTP server để HTML có thể load `.glb`.
- URL trong HTML dùng dạng `/models/...`, còn server map sang `assets/models/...`.

