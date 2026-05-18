import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../domain/entities/saved_character_build.dart';

class SavedCharacterBuildStore {
  static const _fileName = 'saved_character_builds.json';

  Future<List<SavedCharacterBuild>> loadBuilds() async {
    final file = await _buildsFile();
    if (!await file.exists()) return [];

    final raw = await file.readAsString();
    if (raw.trim().isEmpty) return [];

    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map>()
        .map((item) => SavedCharacterBuild.fromJson(
              Map<String, Object?>.from(item),
            ))
        .where((build) => build.id.isNotEmpty)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> saveBuild(SavedCharacterBuild build) async {
    final builds = await loadBuilds();
    builds.removeWhere((item) => item.id == build.id);
    builds.insert(0, build);
    await _writeBuilds(builds);
  }

  Future<void> _writeBuilds(List<SavedCharacterBuild> builds) async {
    final file = await _buildsFile();
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(
        builds.map((build) => build.toJson()).toList(),
      ),
    );
  }

  Future<File> _buildsFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}${Platform.pathSeparator}$_fileName');
  }
}
