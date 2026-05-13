import 'accessory_slot.dart';

class Character3DObject {
  final String id;
  final String name;
  final String modelPath;
  final String viewerPath;
  final List<double> position;
  final List<double> rotation;
  final List<double> scale;
  final Map<AccessorySlot, String> defaultAccessoryIds;

  const Character3DObject({
    required this.id,
    required this.name,
    required this.modelPath,
    required this.viewerPath,
    this.position = const [0, 0, 0],
    this.rotation = const [0, 0, 0],
    this.scale = const [1, 1, 1],
    this.defaultAccessoryIds = const {},
  });

  Map<String, Object?> toBaseViewerConfig() {
    return {
      'id': id,
      'name': name,
      'slot': 'body',
      'url': viewerPath,
      'position': position,
      'rotation': rotation,
      'scale': scale,
      'hidesSlots': const <String>[],
    };
  }
}
