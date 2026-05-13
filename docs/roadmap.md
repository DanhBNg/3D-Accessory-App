# Kế Hoạch Phát Triển

## Giai Đoạn 1 - Demo Ổn Định

- Giữ app chạy ổn với VFX mock data.
- Giữ 3D viewer load được:
  - base character
  - hair
  - hat
- Cho phép bật/tắt accessory cơ bản.
- Tách code theo feature-first clean-lite.

Trạng thái: đã triển khai.

## Giai Đoạn 2 - Mở Rộng Accessory

Việc nên làm tiếp:

- Chuẩn hóa model 3D thành `Character3DObject`:
  - mỗi nhân vật là một object riêng
  - object có base model riêng
  - object có danh sách accessory mặc định theo slot
  - accessory vẫn là các part gắn vào object, ví dụ hair, hat, glasses, mask, outfit
- Thêm model cho:
  - glasses
  - masks
  - outfits
  - nhiều style hair/hat
- Thêm thumbnail thật cho mỗi accessory.
- Cho phép chọn nhiều item theo slot.
- Thay logic hard-code trong HTML bằng config accessory động từ Flutter sang JavaScript.

## Giai Đoạn 3 - Quản Lý State Tốt Hơn

Khi UI phức tạp hơn:

- Tách state selection accessory ra khỏi `StatefulWidget`.
- Có thể dùng `ChangeNotifier`, Riverpod hoặc Bloc.
- Thêm model selected state:
  - selected hair
  - selected hat
  - selected glasses
  - hidden slots

## Giai Đoạn 4 - Backend Hoặc AI API

Chỉ nên thêm Clean Architecture đầy đủ khi có nhu cầu thật:

- API tạo VFX.
- User inventory.
- Download accessory từ server.
- Login/user profile.
- Payment hoặc unlock item.

Khi đó mới thêm:

```text
data/
  datasources/
  dto/
  repositories/
domain/
  repositories/
  usecases/
presentation/
  state/
```
