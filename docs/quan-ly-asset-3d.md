# Quản lý asset 3D

## Vị trí asset

- Nhân vật: `assets/models/characters_rigged/`
- Phụ kiện nón: `assets/models/hats/`
- Phụ kiện kính: `assets/models/glasses/`
- Phụ kiện khẩu trang: `assets/models/masks/`
- Phụ kiện khác: `assets/models/others/`
- Phòng 3D: `assets/models/room/`
- Animation: `assets/models/animations/`
- Viewer WebView: `assets/web/`

Các asset cần được khai báo trong `pubspec.yaml` để Flutter đóng gói vào app.

## Thêm nhân vật mới

1. Đặt file `.glb` vào `assets/models/characters_rigged/`.
2. Khai báo asset trong `pubspec.yaml` nếu thư mục chưa được include.
3. Thêm một `Character3DObject` trong `character_object_mock_data.dart`.
4. Kiểm tra `viewerPath` theo dạng `/models/characters_rigged/<ten-file>.glb`.
5. Chạy app và kiểm tra trên `Character3DDemoScreen` và `CharacterRoomScreen`.

## Thêm phụ kiện mới

1. Đặt file `.glb` vào đúng thư mục slot.
2. Khai báo asset trong `pubspec.yaml`.
3. Thêm `AccessoryItem` trong `accessory_mock_data.dart`.
4. Chọn `slot` phù hợp trong `AccessorySlot`.
5. Chỉnh `position`, `rotation`, `scale` cho vừa nhân vật.
6. Nếu phụ kiện cần ẩn slot khác, thêm vào `hidesSlots`.

Ví dụ: nón có thể ẩn tóc bằng `hidesSlots: [AccessorySlot.hair]`.

## Quy ước đường dẫn

- `modelPath`: đường dẫn Flutter asset, ví dụ `assets/models/hats/bucket_hat.glb`.
- `viewerPath`: đường dẫn HTTP cục bộ cho WebView, ví dụ `/models/hats/bucket_hat.glb`.

`Local3DAssetServer` map mọi request `/models/...` sang `assets/models/...`.

## Kiểm tra file GLB

Repo có `check_glb.dart` và `check_glb.py` để hỗ trợ kiểm tra nhanh file `.glb`. Khi asset không hiển thị, nên kiểm tra:

- File có được khai báo trong `pubspec.yaml` không.
- `viewerPath` có đúng với vị trí asset không.
- File `.glb` có mesh/material/animation hợp lệ không.
- Scale và vị trí có làm model nằm ngoài camera không.
