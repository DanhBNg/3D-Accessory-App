import '../domain/entities/accessory_slot.dart';
import '../domain/entities/character_3d_object.dart';

const List<Character3DObject> characterObjects = [
  Character3DObject(
    id: 'base_character_1',
    name: 'Character 1',
    modelPath: 'assets/models/character/base_character.glb',
    viewerPath: '/models/character/base_character.glb',
    defaultAccessoryIds: {
      AccessorySlot.hair: 'hair_style_1',
      AccessorySlot.hat: 'hat_style_1',
    },
  ),
  Character3DObject(
    id: 'female_body_1',
    name: 'Female 1',
    modelPath: 'assets/models/character/female_body_1.glb',
    viewerPath: '/models/character/female_body_1.glb',
    defaultAccessoryIds: {
      AccessorySlot.hair: 'hair_style_1',
      AccessorySlot.glasses: 'glassy_round',
    },
  ),
  Character3DObject(
    id: 'female_body_2',
    name: 'Female 2',
    modelPath: 'assets/models/character/female_body_2.glb',
    viewerPath: '/models/character/female_body_2.glb',
    defaultAccessoryIds: {
      AccessorySlot.hair: 'hair_style_1',
      AccessorySlot.hat: 'beanie_hat',
      AccessorySlot.mask: 'medical_mask',
    },
  ),
  Character3DObject(
    id: 'male_body_2',
    name: 'Male 2',
    modelPath: 'assets/models/character/male_body_2.glb',
    viewerPath: '/models/character/male_body_2.glb',
    defaultAccessoryIds: {
      AccessorySlot.hat: 'bucket_hat',
      AccessorySlot.back: 'mini_backpack',
      AccessorySlot.wrist: 'bracelet',
    },
  ),
];
