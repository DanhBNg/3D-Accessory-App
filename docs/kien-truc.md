# Kiến trúc mã nguồn

## Thư mục chính

- `lib/app/`: cấu hình app Flutter, theme và widget gốc.
- `lib/core/`: màu sắc, widget dùng chung.
- `lib/features/cinematic_vfx/`: màn hình landing và demo preset VFX.
- `lib/features/character_3d/`: domain, dữ liệu mock, lưu build, màn hình chọn phụ kiện và local server.
- `lib/features/character_room/`: màn hình phòng 3D, chọn nhân vật đã lưu và animation.
- `assets/web/`: viewer HTML dùng Three.js.
- `assets/models/`: model nhân vật, phụ kiện, phòng và animation.

## Vai trò các lớp quan trọng

- `CinematicApp`: cấu hình `MaterialApp`, theme tối và màn hình đầu.
- `Character3DDemoScreen`: quản lý lựa chọn nhân vật, slot phụ kiện, save build và gửi cấu hình sang WebView.
- `CharacterRoomScreen`: nạp build đã lưu, gửi cấu hình nhân vật sang room viewer và gọi animation.
- `Local3DAssetServer`: mở HTTP server loopback để WebView đọc asset Flutter.
- `SavedCharacterBuildStore`: đọc/ghi `saved_character_builds.json` trong thư mục documents của app.
- `AccessoryItem`: mô tả phụ kiện, slot, đường dẫn model và transform.
- `Character3DObject`: mô tả nhân vật cơ sở và cấu hình gửi sang viewer.

## Ranh giới Flutter và Three.js

Flutter không trực tiếp render model 3D trong cây widget. Flutter chỉ:

- Hiển thị control.
- Quản lý trạng thái người dùng.
- Tạo JSON cấu hình.
- Gọi JavaScript qua `WebViewController.runJavaScript`.

Three.js trong WebView chịu trách nhiệm:

- Tải `.glb` bằng `GLTFLoader`.
- Tạo scene, camera, light, renderer.
- Gắn hoặc bỏ mesh phụ kiện.
- Fit camera, xoay nhân vật, phát animation.
- Dispose geometry/material khi thay model.
