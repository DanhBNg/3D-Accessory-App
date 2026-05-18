class SavedCharacterBuild {
  final String id;
  final String name;
  final String characterId;
  final Map<String, String> accessoryIdsBySlot;
  final DateTime createdAt;

  const SavedCharacterBuild({
    required this.id,
    required this.name,
    required this.characterId,
    required this.accessoryIdsBySlot,
    required this.createdAt,
  });

  factory SavedCharacterBuild.fromJson(Map<String, Object?> json) {
    return SavedCharacterBuild(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Saved Character',
      characterId: json['characterId'] as String? ?? 'character1',
      accessoryIdsBySlot:
          (json['accessoryIdsBySlot'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, value.toString()),
      ),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'characterId': characterId,
      'accessoryIdsBySlot': accessoryIdsBySlot,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
