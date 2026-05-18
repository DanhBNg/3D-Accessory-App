import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Provide file path');
    return;
  }
  
  final file = File(args[0]);
  if (!await file.exists()) {
    print('File not found: ${args[0]}');
    return;
  }
  
  try {
    final bytes = await file.readAsBytes();
    final byteData = ByteData.view(bytes.buffer);
    
    final magic = String.fromCharCodes(bytes.sublist(0, 4));
    if (magic != 'glTF') {
      print('Not glTF');
      return;
    }
    
    final chunk0Len = byteData.getUint32(12, Endian.little);
    final chunk0Type = String.fromCharCodes(bytes.sublist(16, 20));
    
    if (chunk0Type != 'JSON') {
      print('First chunk is not JSON: $chunk0Type');
      return;
    }
    
    final jsonStr = utf8.decode(bytes.sublist(20, 20 + chunk0Len));
    final gltf = jsonDecode(jsonStr);
    
    final hasAnimations = gltf.containsKey('animations');
    final hasSkins = gltf.containsKey('skins');
    
    print('--- File: ${args[0]} ---');
    print('Has Rig (Skins): $hasSkins');
    if (hasSkins) {
      print('Number of skins: ${(gltf["skins"] as List).length}');
    }
    print('Has Animations: $hasAnimations');
    if (hasAnimations) {
      final anims = gltf['animations'] as List;
      print('Number of animations: ${anims.length}');
      for (var i = 0; i < anims.length; i++) {
        print('  Animation $i: ${anims[i]["name"] ?? "Unnamed"}');
      }
    }
    print('Total Nodes: ${(gltf["nodes"] as List?)?.length ?? 0}');
    print('Total Meshes: ${(gltf["meshes"] as List?)?.length ?? 0}');
    print('---------------------------------');
  } catch (e) {
    print('Error: $e');
  }
}
