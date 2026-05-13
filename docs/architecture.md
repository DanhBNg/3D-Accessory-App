# Kiến Trúc Và Cấu Trúc Thư Mục

## Cấu Trúc Chính

```text
lib/
  main.dart

  app/
    cinematic_app.dart
    app_theme.dart

  core/
    constants/
      app_colors.dart
    widgets/
      gradient_action_button.dart

  features/
    cinematic_vfx/
      data/
        vfx_mock_data.dart
      presentation/
        screens/
          landing_screen.dart
          vfx_generator_screen.dart
        widgets/
          hover_video_card.dart

    character_3d/
      data/
        accessory_mock_data.dart
      domain/
        entities/
          accessory_item.dart
          accessory_slot.dart
      presentation/
        screens/
          character_3d_demo_screen.dart
        widgets/
          accessory_category_tabs.dart
          accessory_option_card.dart
          part_switch.dart
      web/
        local_3d_server.dart
```

## Vai Trò Từng Khu Vực

### `lib/main.dart`

Chỉ là entrypoint:

```dart
void main() {
  runApp(const CinematicApp());
}
```

Không đặt UI, mock data, server hoặc business logic trong file này.

### `lib/app/`

Chứa phần cấu hình app-level:

- `cinematic_app.dart`: MaterialApp, home screen, title, theme.
- `app_theme.dart`: theme dùng chung.

### `lib/core/`

Chứa phần dùng chung nhiều feature:

- constants màu sắc.
- widget dùng chung như gradient action button.

Không đặt logic riêng của một feature vào `core/`.

### `features/cinematic_vfx/`

Feature VFX gồm:

- Mock data preset video.
- Landing screen.
- Generator screen.
- Video preview card.

Hiện tại chưa cần domain layer vì VFX vẫn chỉ là UI demo + mock data.

### `features/character_3d/`

Feature 3D có `data/domain/presentation/web` vì khả năng mở rộng cao hơn:

- `domain/entities`: định nghĩa accessory.
- `data`: mock accessory list.
- `presentation`: màn hình và widgets.
- `web`: local HTTP server phục vụ HTML và GLB cho WebView.

