# Tổng Quan Dự Án

## Mục Tiêu

App Flutter demo hai luồng trải nghiệm:

1. Cinematic VFX
   - Landing screen giới thiệu preset VFX.
   - Màn tạo VFX mock bằng ảnh upload giả lập.
   - Video preview dùng `video_player`.

2. 3D Character Accessory
   - Hiển thị nhân vật GLB trong WebView.
   - Load model bằng Three.js trong `assets/web/character_viewer.html`.
   - Local HTTP server trong Flutter để WebView đọc asset local.
   - Bật/tắt hair và hat, xoay nhân vật, reset góc nhìn.

## Công Nghệ Chính

- Flutter
- Dart
- `video_player`
- `webview_flutter`
- Three.js trong HTML viewer
- Asset local `.glb`

## Quyết Định Kiến Trúc

App đang ở giai đoạn demo UI + mock data + asset local, nên dùng **clean-lite**:

- Có chia `data/domain/presentation` cho feature cần mở rộng.
- Chưa thêm repository/usecase/datasource/DTO/mapper nếu chưa có backend hoặc state management phức tạp.

Khi app có backend, AI API, user inventory, download accessory từ server, lúc đó mới thêm các lớp như:

- `repositories/`
- `usecases/`
- `datasources/`
- DTO/mapper
- State management rõ ràng hơn như Bloc/Riverpod/Provider

