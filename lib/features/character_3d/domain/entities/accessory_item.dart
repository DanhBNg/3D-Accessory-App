import 'accessory_slot.dart';

class AccessoryTransform {
  final List<double> position;
  final List<double> rotation;
  final List<double> scale;

  const AccessoryTransform({
    this.position = const [0, 0, 0],
    this.rotation = const [0, 0, 0],
    this.scale = const [1, 1, 1],
  });
}

class AccessoryItem {
  final String id;
  final String name;
  final AccessorySlot slot;
  final String modelPath;
  final String viewerPath;
  final List<double> position;
  final List<double> rotation;
  final List<double> scale;
  final List<AccessorySlot> hidesSlots;
  final Map<String, AccessoryTransform> characterTransforms;
  final String? thumbnailPath;

  const AccessoryItem({
    required this.id,
    required this.name,
    required this.slot,
    required this.modelPath,
    required this.viewerPath,
    this.position = const [0, 0, 0],
    this.rotation = const [0, 0, 0],
    this.scale = const [1, 1, 1],
    this.hidesSlots = const [],
    this.characterTransforms = const {},
    this.thumbnailPath,
  });

  Map<String, Object?> toViewerConfig({String? characterId}) {
    final transform = characterId == null
        ? null
        : characterTransforms[characterId];

    return {
      'id': id,
      'name': name,
      'slot': slot.key,
      'url': viewerPath,
      'position': transform?.position ?? position,
      'rotation': transform?.rotation ?? rotation,
      'scale': transform?.scale ?? scale,
      'hidesSlots': hidesSlots.map((slot) => slot.key).toList(),
    };
  }
}
