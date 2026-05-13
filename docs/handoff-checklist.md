# Checklist Chuyển Giao

## Khi Gửi Lại Cho AI Assistant

Gửi tối thiểu các file/tài liệu sau:

- `docs/README.md`
- `docs/project-overview.md`
- `docs/architecture.md`
- `docs/character-3d-implementation.md`
- `pubspec.yaml`
- `lib/main.dart`
- toàn bộ `lib/app/`, `lib/core/`, `lib/features/`
- `assets/web/character_viewer.html`

Nếu cần debug 3D, gửi thêm:

- danh sách file trong `assets/models/`
- ảnh/video lỗi nếu WebView không render
- log console hoặc error hiện trên màn hình app

## Lệnh Kiểm Tra Nên Chạy

```powershell
dart format lib
dart analyze
flutter test
```

Trong môi trường này, nếu Dart/Flutter bị lỗi telemetry permission, có thể chạy với `APPDATA` trỏ về thư mục project:

```powershell
$env:APPDATA=(Get-Location).Path
C:\flutter\bin\cache\dart-sdk\bin\dart.exe analyze
```

## Các Điểm Cần Nhớ

- App dùng clean-lite, không phải Clean Architecture đầy đủ.
- `main.dart` không nên phình to trở lại.
- Mỗi feature tự giữ screen/widget/data riêng.
- `character_3d/web/local_3d_server.dart` là phần quan trọng để WebView load asset local.
- Khi đổi path model, phải cập nhật đồng thời:
  - `pubspec.yaml`
  - `local_3d_server.dart`
  - `character_viewer.html`
  - `accessory_mock_data.dart`

