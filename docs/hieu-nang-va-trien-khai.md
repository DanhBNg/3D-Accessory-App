# Hiệu năng và triển khai

## Điểm cần chú ý

Viewer 3D chạy trong WebView, nên hiệu năng phụ thuộc vào cả Flutter, WebView runtime và Three.js. Các điểm nhạy cảm nhất là dung lượng `.glb`, số lượng texture, số mesh/material và animation clip.

## Tối ưu model

- Giảm polygon trước khi đưa vào app nếu model quá nặng.
- Nén texture và tránh texture kích thước quá lớn.
- Gộp mesh/material khi không cần tách riêng.
- Đặt origin, scale và trục model nhất quán để giảm logic chỉnh tay.
- Với animation, giữ skeleton và tên bone ổn định giữa các nhân vật nếu muốn tái sử dụng clip.

## Tối ưu viewer

- Giới hạn `renderer.setPixelRatio(...)` như hiện tại để tránh quá tải GPU trên mobile.
- Dispose object cũ khi thay nhân vật hoặc phụ kiện.
- Cache animation clip khi phát lại cùng URL.
- Tránh reload toàn bộ WebView nếu chỉ cần đổi config.
- Kiểm tra lỗi tải asset trong console/WebView log khi model không xuất hiện.

## Triển khai asset

Hiện project đóng gói asset trong app và phục vụ qua `Local3DAssetServer`. Cách này phù hợp cho demo offline và kiểm soát phiên bản asset.

Nếu chuyển sang CDN:

- Giữ cấu trúc URL tương thích với `viewerPath`.
- Bật CORS cho `.glb` và texture liên quan.
- Dùng cache header có versioning rõ ràng.
- Có fallback hoặc thông báo lỗi khi mạng yếu.
- Kiểm tra kỹ trên Android/iOS vì WebView có khác biệt về chính sách tải tài nguyên.

## Checklist release

- `flutter analyze` không còn lỗi nghiêm trọng.
- App chạy được trên target chính.
- Viewer chọn phụ kiện tải được tất cả nhân vật.
- Room viewer tải được phòng, nhân vật đã lưu và animation.
- Asset mới đã khai báo trong `pubspec.yaml`.
- Dung lượng app sau khi thêm model vẫn chấp nhận được.
