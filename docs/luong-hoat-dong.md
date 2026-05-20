# Luồng hoạt động

## Khởi động app

1. `main.dart` gọi `runApp(const CinematicApp())`.
2. `CinematicApp` mở `LandingScreen`.
3. Người dùng chọn một màn hình demo từ landing.

## Luồng chọn nhân vật và phụ kiện

1. `Character3DDemoScreen` tạo `Local3DAssetServer`.
2. Server bind vào `127.0.0.1` với port ngẫu nhiên.
3. WebView mở `/character_viewer.html` từ server cục bộ.
4. Khi viewer load xong, Flutter gọi `setCharacterObject(...)`.
5. Viewer tải nhân vật cơ sở và các phụ kiện theo JSON.
6. Người dùng đổi nhân vật hoặc đổi phụ kiện, Flutter gửi lại cấu hình mới.
7. Người dùng bấm lưu, app ghi `SavedCharacterBuild` vào JSON cục bộ.

## Luồng phòng 3D và animation

1. `CharacterRoomScreen` mở `/character_room_viewer.html`.
2. App đọc các build đã lưu từ `SavedCharacterBuildStore`.
3. Nếu có build, build mới nhất được chọn mặc định.
4. Flutter gửi cấu hình nhân vật sang `setCharacterObject(...)`.
5. Viewer tải phòng, nhân vật, phụ kiện và giữ nhân vật đứng trên sàn.
6. Khi người dùng chọn action, Flutter gọi `playExternalAnimation("<url>")`.
7. Viewer lấy animation clip từ file `.glb`, map track animation vào skeleton nhân vật và phát bằng `AnimationMixer`.

## Giao tiếp Flutter sang WebView

Các hàm JavaScript chính đang được Flutter gọi:

- `setCharacterObject(config)`: nạp nhân vật và phụ kiện.
- `rotateCharacter(deltaY)`: xoay nhân vật trong viewer chọn phụ kiện.
- `resetView()`: đưa viewer chọn phụ kiện về góc nhìn mặc định.
- `playExternalAnimation(url)`: phát animation trong phòng 3D.

JSON gửi sang viewer nên giữ dạng dữ liệu thuần: `id`, `name`, `base`, `accessories`, `position`, `rotation`, `scale`, `hidesSlots`.
