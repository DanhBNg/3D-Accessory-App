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
];
