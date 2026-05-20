# Tài liệu dự án

Đây là bộ tài liệu tiếng Việt cho project `flutter_3d_accessory`. Tài liệu tập trung vào cách ứng dụng đang hoạt động trong repo hiện tại, không mô tả các ý tưởng chưa có trong code.

## Mục lục

- [Tổng quan dự án](tong-quan.md)
- [Kiến trúc mã nguồn](kien-truc.md)
- [Luồng hoạt động](luong-hoat-dong.md)
- [Quản lý asset 3D](quan-ly-asset-3d.md)
- [Quy trình phát triển](quy-trinh-phat-trien.md)
- [Hiệu năng và triển khai](hieu-nang-va-trien-khai.md)

## Thành phần chính

- Flutter dựng giao diện, điều hướng màn hình và lưu cấu hình nhân vật.
- WebView mở viewer HTML cục bộ trong `assets/web/`.
- Three.js tải model `.glb`, gắn phụ kiện, điều khiển camera và phát animation.
- Local HTTP server trong app phục vụ asset Flutter cho WebView qua `http://127.0.0.1:<port>`.
