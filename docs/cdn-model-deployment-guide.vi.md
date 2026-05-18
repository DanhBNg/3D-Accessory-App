# Huong Dan Day Model Len CDN

Tai lieu nay la ban tam thoi de huong dan dua cac file GLB trong `assets/models/` len CDN. Muc tieu chinh la giam dung luong APK va cho phep cap nhat model/animation/phu kien ma khong can build lai app.

## Trang Thai Hien Tai Cua Project

Project hien tai uu tien load model local de mo man hinh nhanh hon. R2 duoc xem nhu huong backup/thu nghiem CDN, khong phai primary path trong code hien tai.

R2 public base URL dang dung de tham khao:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models
```

Neu sau nay muon chuyen lai sang CDN, doi cac `viewerPath`, room, va animation URL sang R2 theo cac muc ben duoi.

Nhung file 3D da bi xoa khoi `assets/models/` duoc xem la khong con can thiet va khong nen tiep tuc tham chieu trong app:

```text
assets/models/hair/hair_style_1.glb
assets/models/hats/hat_style_1.glb
assets/models/glasses/glassy_round.glb
assets/models/masks/ninja_mask.glb
```

Danh sach accessory trong app chi nen giu cac file con ton tai local hoac cac URL CDN da duoc xac nhan can dung.

## Khi Nao Nen Dung CDN

Nen dung CDN khi:

- APK qua lon vi bundle nhieu file GLB.
- Can them/sua model ma khong muon release app moi.
- Muon lazy-load chi nhung asset nguoi dung thuc su mo.
- Muon tach asset 3D khoi source/app bundle.

Khong nen ky vong CDN tu dong lam FPS muot hon. FPS van phu thuoc vao polygon, texture, material, shadow, animation, va per-frame work.

## Yeu Cau CDN

CDN can co:

- Public HTTPS URL.
- Ho tro `GET` file `.glb`.
- CORS cho phep WebView/Three.js load asset.
- Cache header on dinh cho file bat bien.
- Duong dan asset on dinh, de app co the tham chieu bang config.

Header khuyen nghi:

```text
Access-Control-Allow-Origin: *
Cache-Control: public, max-age=31536000, immutable
Content-Type: model/gltf-binary
```

Neu CDN khong set dung `Content-Type`, Three.js thuong van co the load theo binary, nhung set dung van tot hon.

## Tao Bucket Tren Cloudflare R2

### 1. Tao bucket

1. Dang nhap Cloudflare Dashboard.
2. Mo **R2 Object Storage**.
3. Chon **Create bucket**.
4. Dat ten bucket, vi du:

```text
flutter-3d-accessory-models
```

5. Tao bucket voi setting mac dinh neu chua co yeu cau rieng ve region/jurisdiction.

Ten bucket chi nen dung chu thuong, so, va dau gach ngang de de quan ly URL/script ve sau.

### 2. Upload thu model

Trong bucket vua tao, upload thu mot file nho truoc:

```text
models/animations/breathing_idle.glb
```

Sau do upload tiep theo cau truc:

```text
models/
  characters_rigged/
  animations/
  room/
  hats/
  glasses/
  masks/
  others/
```

Neu Cloudflare UI khong cho upload folder truc tiep nhu mong muon, co the upload bang tool S3-compatible sau nay. Giai do dau nen upload thu vai file tren UI de test public URL/CORS truoc.

### 3. Bat public access

Co 2 cach public asset:

#### Cach nhanh: R2.dev public URL

Trong bucket:

1. Mo tab/settings lien quan den **Public access**.
2. Bat public access qua domain `r2.dev`.
3. Cloudflare se cap mot public URL dang gan giong:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev
```

URL model se co dang:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/animations/breathing_idle.glb
```

Cach nay nhanh de test, nhung ve production nen dung custom domain.

#### Cach production: Custom domain

Neu domain dang nam tren Cloudflare DNS, nen gan custom domain cho bucket, vi du:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev
```

Khi do URL model:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/characters_rigged/character_1.glb
```

Custom domain giup URL dep hon va dung duoc Cloudflare Cache tot hon.

### 4. Cau hinh CORS

Three.js trong WebView can load GLB cross-origin, nen bucket can CORS.

Trong Cloudflare Dashboard:

1. Vao **R2 Object Storage**.
2. Chon bucket.
3. Mo phan **CORS policy**.
4. Them policy cho phep `GET` va `HEAD`.

Policy de test nhanh:

```json
[
  {
    "AllowedOrigins": ["*"],
    "AllowedMethods": ["GET", "HEAD"],
    "AllowedHeaders": ["*"],
    "ExposeHeaders": ["ETag"],
    "MaxAgeSeconds": 3600
  }
]
```

Neu muon chat hon khi da co custom domain/app domain on dinh, thay `*` bang origin cu the. Voi mobile WebView va file asset public, giai do dau co the de `*` de tranh loi CORS trong luc test.

### 5. Test public URL

Mo browser va truy cap truc tiep:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/animations/breathing_idle.glb
```

Hoac:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/animations/breathing_idle.glb
```

Ket qua dung:

- browser tai ve file `.glb`, hoac hien binary/download
- status HTTP la `200`
- khong bi redirect ve trang login
- khong tra ve HTML error page

Neu muon test header, dung:

```text
curl -I https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/animations/breathing_idle.glb
```

Can thay cac header gan nhu:

```text
HTTP/2 200
access-control-allow-origin: *
cache-control: public, max-age=31536000, immutable
```

### 6. Upload toan bo asset

Sau khi test 1 file thanh cong, upload toan bo:

```text
assets/models/characters_rigged/*
assets/models/animations/*
assets/models/room/*
assets/models/hats/*
assets/models/glasses/*
assets/models/masks/*
assets/models/others/*
```

Nen giu duong dan tren R2 trung voi duong dan trong app sau tien to `models/`.

## Cau Truc CDN De Xuat

Giu cau truc gan giong local de code de mapping:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/
  characters_rigged/
    character_1.glb
    character_2.glb
    character_3.glb
  animations/
    breathing_idle.glb
    jumping_down.glb
    spin_act.glb
    hip_hop_dancing.glb
  room/
    room_default.glb
  hats/
    bucket_hat.glb
  glasses/
    cybor_visor.glb
  masks/
    medical_mask.glb
  others/
    mini_backpack.glb
```

Vi du URL:

```text
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/characters_rigged/character_1.glb
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/animations/breathing_idle.glb
https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/room/room_default.glb
```

## Cac File App Can Sua

### 1. Character Data

File:

```text
lib/features/character_3d/data/character_object_mock_data.dart
```

Can doi `viewerPath` tu local path:

```dart
viewerPath: '/models/characters_rigged/character_1.glb',
```

sang CDN URL:

```dart
viewerPath: 'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/characters_rigged/character_1.glb',
```

`modelPath` co the giu lai neu van can local debug, hoac bo dan neu khong dung.

### 2. Accessory Data

File:

```text
lib/features/character_3d/data/accessory_mock_data.dart
```

Doi `viewerPath` cua tung phu kien:

```dart
viewerPath: 'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/hats/bucket_hat.glb',
```

Luu y: cac transform `position`, `rotation`, `scale` van giu nguyen. CDN chi thay doi noi load file.

### 3. Room Viewer HTML

File:

```text
assets/web/character_room_viewer.html
```

Can doi:

```js
const CHARACTER_URLS = {
  character1: '/models/characters_rigged/character_1.glb',
  character2: '/models/characters_rigged/character_2.glb',
  character3: '/models/characters_rigged/character_3.glb'
};
const DEFAULT_IDLE_ANIMATION_URL = '/models/animations/breathing_idle.glb';
```

sang:

```js
const CHARACTER_URLS = {
  character1: 'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/characters_rigged/character_1.glb',
  character2: 'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/characters_rigged/character_2.glb',
  character3: 'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/characters_rigged/character_3.glb'
};
const DEFAULT_IDLE_ANIMATION_URL =
  'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/animations/breathing_idle.glb';
```

Va doi room URL:

```js
loader.loadAsync('/models/room/room_default.glb')
```

sang:

```js
loader.loadAsync('https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/room/room_default.glb')
```

### 4. Animation List Trong Flutter

File:

```text
lib/features/character_room/presentation/screens/character_room_screen.dart
```

Doi cac animation URL:

```dart
url: '/models/animations/breathing_idle.glb',
```

sang:

```dart
url: 'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models/animations/breathing_idle.glb',
```

## Nen Tao Config Trung Tam

De tranh hardcode CDN URL o nhieu noi, nen tao mot file config, vi du:

```text
lib/core/config/model_asset_config.dart
```

Vi du:

```dart
class ModelAssetConfig {
  static const cdnBaseUrl = 'https://pub-6e1031fab6d64ae783723ea951e6cdfa.r2.dev/models';

  static String model(String path) => '$cdnBaseUrl/$path';
}
```

Dung:

```dart
viewerPath: ModelAssetConfig.model('characters_rigged/character_1.glb'),
```

HTML hien tai khong doc truc tiep Dart config, nen co 2 cach:

- tiep tuc hardcode CDN URL trong HTML cho nhanh
- hoac truyen URL tu Flutter sang JS khi init viewer

Ve lau dai, nen de Flutter la nguon config chinh va HTML chi nhan URL/config tu Flutter.

## Cap Nhat pubspec.yaml

Neu da chuyen GLB len CDN va khong can bundle local nua, co the bo cac dong model lon khoi `pubspec.yaml`:

```yaml
assets:
  - assets/web/
```

Va bo dan cac dong:

```yaml
- assets/models/characters_rigged/
- assets/models/animations/
- assets/models/room/
- assets/models/hats/
- assets/models/glasses/
- assets/models/masks/
- assets/models/others/
```

Chi nen bo sau khi da test CDN load on dinh. Trong giai do chuyen doi, co the giu local assets de fallback/debug.

## Checklist Upload

1. Upload tat ca file GLB len CDN theo cau truc de xuat.
2. Mo truc tiep URL GLB tren browser de chac chan file public.
3. Kiem tra response header co CORS:

```text
Access-Control-Allow-Origin: *
```

4. Kiem tra app co load duoc:

- room
- character
- animation idle
- animation action
- accessory da luu
- phu kien attach theo bone khi animation chay

5. Build APK va so sanh dung luong truoc/sau khi bo local GLB khoi `pubspec.yaml`.

## Checklist Loi Thuong Gap

### Model khong hien

Nguyen nhan co the la:

- URL sai.
- CDN chan CORS.
- File chua public.
- CDN tra ve HTML error page thay vi GLB.
- `Content-Type` sai hoac response bi redirect qua auth.

### Animation khong chay

Kiem tra:

- animation URL dung chua
- GLB co `animations.length > 0`
- bone names tuong thich voi character
- CDN co tra ve dung file binary khong

### APK Van Lon

Kiem tra:

- `pubspec.yaml` con bundle `assets/models/**` khong
- build clean lai sau khi sua assets:

```text
flutter clean
flutter pub get
flutter build apk
```

### Lan Dau Mo Cham

Day la tradeoff cua CDN. Co the cai thien bang:

- preload room + idle animation khi vao app
- cache HTTP/CDN tot
- giam dung luong GLB
- hien loading state ro rang

## Huong Di Khuyen Nghi

Lam theo 2 giai do:

1. Giai do chuyen doi:
   - giu local assets
   - them CDN URL vao config
   - test CDN tren debug/release

2. Giai do toi uu APK:
   - bo GLB khoi `pubspec.yaml`
   - chi giu `assets/web/`
   - build lai APK
   - test offline/error state

Khi CDN da on dinh, app nen co loading/error UI tot hon cho truong hop mat mang hoac CDN loi.
