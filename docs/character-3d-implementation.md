# Ghi Chú Triển Khai 3D Character

## Luồng Hoạt Động

1. Flutter mở `Character3DDemoScreen`.
2. Screen khởi động `Local3DAssetServer`.
3. Local server bind vào `127.0.0.1` với port ngẫu nhiên.
4. WebView load `http://127.0.0.1:{port}/character_viewer.html`.
5. HTML dùng Three.js load các file GLB qua URL local:
   - `/models/character/base_character.glb`
   - `/models/hair/hair_style_1.glb`
   - `/models/hats/hat_style_1.glb`
6. Flutter gọi JavaScript để bật/tắt part hoặc xoay/reset view.

## File Quan Trọng

- Flutter screen:
  - `lib/features/character_3d/presentation/screens/character_3d_demo_screen.dart`
- Local server:
  - `lib/features/character_3d/web/local_3d_server.dart`
- HTML viewer:
  - `assets/web/character_viewer.html`

## JavaScript API Hiện Có

HTML viewer expose các function:

```js
setPartVisible(partName, visible)
rotateCharacter(deltaY)
resetView()
```

Flutter gọi bằng:

```dart
_controller.runJavaScript('setPartVisible("hair", true);');
```

## Quy Tắc Hiện Tại

- Nếu `hat` đang visible thì `hair` bị ẩn để tránh mesh tóc xuyên qua mũ.
- Transform của từng model đang hard-code trong `ACCESSORIES` của HTML.
- Khi thêm model mới cần khai báo thêm trong HTML và trong local server.

## Hướng Cải Tiến

Nên đưa accessory config sang một cấu trúc dữ liệu chung để tránh sửa nhiều nơi:

- Flutter giữ danh sách accessory.
- Truyền JSON config sang WebView.
- HTML load model theo config động.

Lúc đó có thể bỏ hard-code từng path trong `character_viewer.html`.

