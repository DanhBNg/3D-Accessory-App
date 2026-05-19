import '../domain/entities/accessory_item.dart';
import '../domain/entities/accessory_slot.dart';

const List<AccessoryItem> accessoryItems = [
  AccessoryItem(
    id: 'bucket_hat',
    name: 'Bucket Hat',
    slot: AccessorySlot.hat,
    modelPath: 'assets/models/hats/bucket_hat.glb',
    viewerPath: '/models/hats/bucket_hat.glb',
    position: [0, 0.90, -0.03],
    scale: [0.62, 0.62, 0.62],
    hidesSlots: [AccessorySlot.hair],
  ),
  AccessoryItem(
    id: 'cybor_visor',
    name: 'Cybor Visor',
    slot: AccessorySlot.glasses,
    modelPath: 'assets/models/glasses/cybor_visor.glb',
    viewerPath: '/models/glasses/cybor_visor.glb',
    position: [0, 0.72, 0.18],
    scale: [0.42, 0.42, 0.42],
  ),
  AccessoryItem(
    id: 'medical_mask',
    name: 'Medical Mask',
    slot: AccessorySlot.mask,
    modelPath: 'assets/models/masks/medical_mask.glb',
    viewerPath: '/models/masks/medical_mask.glb',
    position: [0, 0.61, 0.20],
    scale: [0.42, 0.42, 0.42],
  ),
  AccessoryItem(
    id: 'mini_backpack',
    name: 'Mini Backpack',
    slot: AccessorySlot.back,
    modelPath: 'assets/models/others/mini_backpack.glb',
    viewerPath: '/models/others/mini_backpack.glb',
    position: [0, 0.05, -0.30],
    rotation: [0, 3.14, 0],
    scale: [0.3, 0.3, 0.3],
  ),
];
