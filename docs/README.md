# Flutter 3D Accessory - Project Docs

Prompt guide for consistent 3D model generation: [3D model prompt guide](3d-model-prompt-guide.md)

Tài liệu này dùng để chuyển giao dự án, tiếp tục phát triển ở môi trường khác, hoặc gửi lại cho Codex/AI assistant khi cần khôi phục ngữ cảnh.

## Mục Lục

- [Tổng quan dự án](project-overview.md)
- [Kiến trúc và cấu trúc thư mục](architecture.md)
- [Kế hoạch phát triển](roadmap.md)
- [Ghi chú triển khai 3D Character](character-3d-implementation.md)
- [Quản lý assets](asset-guide.md)
- [Checklist chuyển giao](handoff-checklist.md)

## Trạng Thái Hiện Tại

Dự án đang là Flutter demo gồm hai phần chính:

- `cinematic_vfx`: UI demo tạo cinematic VFX bằng mock data và video preview.
- `character_3d`: demo xem nhân vật 3D bằng WebView, local asset server và Three.js trong HTML.

Kiến trúc hiện tại dùng hướng **feature-first + clean-lite**, chưa dùng Clean Architecture đầy đủ để tránh phức tạp sớm.
