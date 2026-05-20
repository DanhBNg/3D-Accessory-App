# Tổng quan dự án

`flutter_3d_accessory` là ứng dụng Flutter demo cho workflow nhân vật 3D:

- Chọn một nhân vật cơ sở từ `assets/models/characters_rigged/`.
- Gắn hoặc bỏ phụ kiện như nón, kính, khẩu trang, balo.
- Xem nhân vật trong viewer 3D độc lập.
- Lưu cấu hình nhân vật vào bộ nhớ tài liệu của app.
- Mở phòng 3D, chọn nhân vật đã lưu và phát animation bên ngoài.

## Công nghệ sử dụng

- Flutter và Dart cho giao diện, điều hướng, state cục bộ.
- `webview_flutter` để nhúng viewer HTML/JavaScript.
- Three.js trong `assets/web/*.html` để render model `.glb`.
- `path_provider` để lưu danh sách nhân vật đã cấu hình.
- `http`, `model_viewer_plus`, `flutter_scene`, `vector_math`, `video_player` đang có trong dependency của project.

## Cấu trúc trải nghiệm

Màn hình đầu tiên là `LandingScreen`. Từ đó người dùng có thể mở:

- `VFXGeneratorScreen`: khu vực preset VFX mock.
- `Character3DDemoScreen`: chọn nhân vật và phụ kiện.
- `CharacterRoomScreen`: xem nhân vật trong phòng và chạy animation.

Trọng tâm hiện tại của project là pipeline 3D nhân vật, phụ kiện và animation.
