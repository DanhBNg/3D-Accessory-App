# Hệ thống Phụ kiện & Animation 3D bằng Flutter 🚀

Một ứng dụng Flutter thể hiện khả năng kết xuất (render) 3D động, hệ thống gắn phụ kiện mạnh mẽ và các hiệu ứng chuyển động (animation) mượt mà thông qua sự kết hợp giữa WebGL, Three.js và Flutter.

## 🌟 Tính năng Nổi bật

* **Hệ thống Phụ kiện 3D Động:** 
  Tải và gắn chồng các mô hình `.glb` riêng biệt (nón, mặt nạ, kính, balo) lên một nhân vật cơ sở (base character) một cách linh hoạt mà không cần đến các phần mềm 3D bên ngoài để biên dịch trước.
* **Điều chỉnh Vị trí Thời gian thực:** 
  Tinh chỉnh vị trí đặt phụ kiện thông qua các thanh trượt X, Y, Z trên màn hình để canh lề hoàn hảo trên các mô hình nhân vật khác nhau.
* **Hệ thống Animation Sống động:** 
  Hỗ trợ tải các đoạn clip animation `.glb` từ bên ngoài thông qua `THREE.AnimationMixer`.
* **Chuyển đổi Mượt mà:** 
  Cơ chế cross-fading tích hợp sẵn giúp chuyển đổi uyển chuyển giữa các trạng thái chuyển động khác nhau (ví dụ: từ Đứng yên sang Nhảy Hip Hop).
* **Trình chọn Nhân vật & Bảng Điều khiển:** 
  Giao diện người dùng hiện đại, mang tính điện ảnh để thay đổi nhân vật cơ sở, quản lý phụ kiện và kích hoạt các hiệu ứng chuyển động ngay lập tức.

## 🛠️ Công nghệ Sử dụng

* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **Kết xuất 3D (3D Rendering):** `webview_flutter` kết hợp với môi trường Three.js cục bộ (`assets/web/character_room_viewer.html`) để thao tác 3D nâng cao.
* **Các Package khác:** `model_viewer_plus`, `flutter_scene`, `vector_math`.

## 📂 Cấu trúc Dự án

* `lib/` - Mã nguồn Dart chứa Giao diện người dùng (UI) Flutter, quản lý trạng thái (state management) và cầu nối WebView.
* `assets/models/` - Chứa tất cả các tệp `.glb` được phân loại theo thư mục:
  * `characters_rigged/` - Mô hình nhân vật cơ sở.
  * `hats/`, `masks/`, `glasses/`, `others/` - Mô hình phụ kiện.
  * `animations/` - Các clip chuyển động bên ngoài.
* `assets/web/` - Các tệp HTML/JS cục bộ chứa logic Three.js (`character_room_viewer.html`).

## 🚀 Hướng dẫn Cài đặt

### Yêu cầu Hệ thống

* Flutter SDK (`^3.11.4` hoặc tương thích)
* Dart SDK

### Cài đặt

1. **Clone repository về máy:**
   ```bash
   git clone <repository_url>
   cd flutter_3d_accessory
   ```

2. **Cài đặt các thư viện phụ thuộc:**
   ```bash
   flutter pub get
   ```

3. **Chạy ứng dụng:**
   ```bash
   flutter run
   ```

## 🎮 Cơ chế Hoạt động

Ứng dụng sử dụng WebView để kết xuất một không gian (scene) Three.js tại máy cục bộ (local). Flutter giao tiếp với môi trường JavaScript thông qua JavaScript channels.
* Khi người dùng chọn một phụ kiện trên giao diện Flutter, một thông điệp (message) sẽ được gửi tới JS để tải mô hình `.glb` và gắn nó vào một vị trí xương (bone) cụ thể trên nhân vật cơ sở.
* Các chuyển động (animation) được tải động và `AnimationAction.crossFadeTo()` được sử dụng để đảm bảo các chuyển động được chuyển tiếp một cách mượt mà nhất.
* Các thanh trượt điều chỉnh vị trí trên Flutter gửi dữ liệu bù (offset) theo thời gian thực để tinh chỉnh vị trí và độ xoay của các mesh phụ kiện được đính kèm.

