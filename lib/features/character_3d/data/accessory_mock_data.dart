import '../domain/entities/accessory_item.dart';
import '../domain/entities/accessory_slot.dart';

const List<AccessoryItem> accessoryItems = [
  AccessoryItem(
    id: 'hair_style_1',
    name: 'Hair 1',
    slot: AccessorySlot.hair,
    modelPath: 'assets/models/hair/hair_style_1.glb',
    viewerPath: '/models/hair/hair_style_1.glb',
    position: [0, 0.87, 0],
    rotation: [0, 0.02, 0],
    scale: [0.49, 0.49, 0.49],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.91, 0],
        rotation: [0, 0.02, 0],
        scale: [0.47, 0.47, 0.47],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.90, 0],
        rotation: [0, 0.02, 0],
        scale: [0.48, 0.48, 0.48],
      ),
    },
    thumbnailPath: 'assets/thumbnails/hair/hair_style_1.png',
  ),
  AccessoryItem(
    id: 'beanie_hat',
    name: 'Beanie',
    slot: AccessorySlot.hat,
    modelPath: 'assets/models/hats/beanie_hat.glb',
    viewerPath: '/models/hats/beanie_hat.glb',
    position: [0, 0.91, -0.02],
    scale: [0.58, 0.58, 0.58],
    hidesSlots: [AccessorySlot.hair],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.94, -0.02],
        scale: [0.55, 0.55, 0.55],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.93, -0.02],
        scale: [0.56, 0.56, 0.56],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.90, -0.02],
        scale: [0.61, 0.61, 0.61],
      ),
    },
  ),
  AccessoryItem(
    id: 'bucket_hat',
    name: 'Bucket Hat',
    slot: AccessorySlot.hat,
    modelPath: 'assets/models/hats/bucket_hat.glb',
    viewerPath: '/models/hats/bucket_hat.glb',
    position: [0, 0.90, -0.03],
    scale: [0.62, 0.62, 0.62],
    hidesSlots: [AccessorySlot.hair],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.93, -0.03],
        scale: [0.59, 0.59, 0.59],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.92, -0.03],
        scale: [0.60, 0.60, 0.60],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.89, -0.03],
        scale: [0.65, 0.65, 0.65],
      ),
    },
  ),
  AccessoryItem(
    id: 'hat_style_1',
    name: 'Hat 1',
    slot: AccessorySlot.hat,
    modelPath: 'assets/models/hats/hat_style_1.glb',
    viewerPath: '/models/hats/hat_style_1.glb',
    position: [0, 0.88, -0.04],
    scale: [0.60, 0.60, 0.60],
    hidesSlots: [AccessorySlot.hair],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.92, -0.04],
        scale: [0.57, 0.57, 0.57],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.91, -0.04],
        scale: [0.58, 0.58, 0.58],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.88, -0.04],
        scale: [0.63, 0.63, 0.63],
      ),
    },
    thumbnailPath: 'assets/thumbnails/hats/hat_style_1.png',
  ),
  AccessoryItem(
    id: 'cybor_visor',
    name: 'Cybor Visor',
    slot: AccessorySlot.glasses,
    modelPath: 'assets/models/glasses/cybor_visor.glb',
    viewerPath: '/models/glasses/cybor_visor.glb',
    position: [0, 0.72, 0.18],
    scale: [0.42, 0.42, 0.42],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.75, 0.17],
        scale: [0.39, 0.39, 0.39],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.74, 0.17],
        scale: [0.40, 0.40, 0.40],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.71, 0.19],
        scale: [0.44, 0.44, 0.44],
      ),
    },
  ),
  AccessoryItem(
    id: 'glassy_round',
    name: 'Round Glasses',
    slot: AccessorySlot.glasses,
    modelPath: 'assets/models/glasses/glassy_round.glb',
    viewerPath: '/models/glasses/glassy_round.glb',
    position: [0, 0.72, 0.18],
    scale: [0.42, 0.42, 0.42],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.75, 0.17],
        scale: [0.39, 0.39, 0.39],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.74, 0.17],
        scale: [0.40, 0.40, 0.40],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.71, 0.19],
        scale: [0.44, 0.44, 0.44],
      ),
    },
  ),
  AccessoryItem(
    id: 'medical_mask',
    name: 'Medical Mask',
    slot: AccessorySlot.mask,
    modelPath: 'assets/models/masks/medical_mask.glb',
    viewerPath: '/models/masks/medical_mask.glb',
    position: [0, 0.61, 0.20],
    scale: [0.42, 0.42, 0.42],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.64, 0.19],
        scale: [0.39, 0.39, 0.39],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.63, 0.19],
        scale: [0.40, 0.40, 0.40],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.60, 0.21],
        scale: [0.44, 0.44, 0.44],
      ),
    },
  ),
  AccessoryItem(
    id: 'ninja_mask',
    name: 'Ninja Mask',
    slot: AccessorySlot.mask,
    modelPath: 'assets/models/masks/ninja_mask.glb',
    viewerPath: '/models/masks/ninja_mask.glb',
    position: [0, 0.61, 0.17],
    scale: [0.46, 0.46, 0.46],
    hidesSlots: [AccessorySlot.glasses],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.64, 0.16],
        scale: [0.43, 0.43, 0.43],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.63, 0.16],
        scale: [0.44, 0.44, 0.44],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.60, 0.18],
        scale: [0.48, 0.48, 0.48],
      ),
    },
  ),
  AccessoryItem(
    id: 'mini_backpack',
    name: 'Mini Backpack',
    slot: AccessorySlot.back,
    modelPath: 'assets/models/others/mini_backpack.glb',
    viewerPath: '/models/others/mini_backpack.glb',
    position: [0, 0.30, -0.30],
    rotation: [0, 3.14, 0],
    scale: [0.55, 0.55, 0.55],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0, 0.33, -0.28],
        rotation: [0, 3.14, 0],
        scale: [0.50, 0.50, 0.50],
      ),
      'female_body_2': AccessoryTransform(
        position: [0, 0.32, -0.28],
        rotation: [0, 3.14, 0],
        scale: [0.51, 0.51, 0.51],
      ),
      'male_body_2': AccessoryTransform(
        position: [0, 0.29, -0.32],
        rotation: [0, 3.14, 0],
        scale: [0.58, 0.58, 0.58],
      ),
    },
  ),
  AccessoryItem(
    id: 'bracelet',
    name: 'Bracelet',
    slot: AccessorySlot.wrist,
    modelPath: 'assets/models/others/bracelet.glb',
    viewerPath: '/models/others/bracelet.glb',
    position: [0.32, 0.14, 0.03],
    rotation: [0, 0, 1.57],
    scale: [0.18, 0.18, 0.18],
    characterTransforms: {
      'female_body_1': AccessoryTransform(
        position: [0.29, 0.16, 0.03],
        rotation: [0, 0, 1.57],
        scale: [0.16, 0.16, 0.16],
      ),
      'female_body_2': AccessoryTransform(
        position: [0.30, 0.15, 0.03],
        rotation: [0, 0, 1.57],
        scale: [0.17, 0.17, 0.17],
      ),
      'male_body_2': AccessoryTransform(
        position: [0.34, 0.13, 0.03],
        rotation: [0, 0, 1.57],
        scale: [0.19, 0.19, 0.19],
      ),
    },
  ),
];
