# Quy trình phát triển

## Cài đặt

```bash
flutter pub get
```

## Chạy app

```bash
flutter run
```

Khi cần chọn thiết bị cụ thể:

```bash
flutter devices
flutter run -d <device-id>
```

## Kiểm tra trước khi commit

```bash
flutter analyze
flutter test
```

Nếu thay đổi asset hoặc viewer HTML, nên chạy app thật để kiểm tra WebView vì `flutter analyze` không bắt được lỗi JavaScript runtime.

## Quy trình thêm chức năng 3D

1. Thêm hoặc cập nhật entity/domain nếu cần dữ liệu mới.
2. Cập nhật mock data hoặc store tương ứng.
3. Cập nhật màn hình Flutter để gửi cấu hình mới sang viewer.
4. Cập nhật `assets/web/*.html` để xử lý cấu hình mới.
5. Kiểm tra trên ít nhất một nhân vật và một phụ kiện.
6. Kiểm tra lại room viewer nếu thay đổi ảnh hưởng animation hoặc skeleton.

## Lưu ý khi sửa viewer HTML

- Giữ tên hàm JavaScript công khai ổn định nếu Flutter đang gọi.
- Dispose geometry/material khi bỏ model cũ để giảm rò rỉ bộ nhớ.
- Không hard-code port local server; Flutter luôn mở viewer bằng origin trả về từ `Local3DAssetServer`.
- Khi thêm import JS từ CDN, cần kiểm tra nền tảng mobile vì WebView có thể bị chặn mạng hoặc chậm tải.

## Lưu dữ liệu người dùng

Build nhân vật được lưu thành `saved_character_builds.json` trong thư mục documents của app. Dữ liệu hiện gồm:

- `id`
- `name`
- `characterId`
- `accessoryIdsBySlot`
- `createdAt`

Khi đổi schema, cần giữ backward compatibility trong `SavedCharacterBuild.fromJson`.
