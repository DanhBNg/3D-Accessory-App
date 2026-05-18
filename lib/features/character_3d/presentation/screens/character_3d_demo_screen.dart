import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/accessory_mock_data.dart';
import '../../data/character_object_mock_data.dart';
import '../../data/saved_character_build_store.dart';
import '../../domain/entities/accessory_item.dart';
import '../../domain/entities/accessory_slot.dart';
import '../../domain/entities/character_3d_object.dart';
import '../../domain/entities/saved_character_build.dart';
import '../../web/local_3d_server.dart';
import '../widgets/accessory_category_tabs.dart';
import '../widgets/accessory_option_card.dart';

class Character3DDemoScreen extends StatefulWidget {
  const Character3DDemoScreen({super.key});

  @override
  State<Character3DDemoScreen> createState() => _Character3DDemoScreenState();
}

class _Character3DDemoScreenState extends State<Character3DDemoScreen> {
  final _assetServer = Local3DAssetServer();
  final _savedBuildStore = SavedCharacterBuildStore();
  late final WebViewController _controller;

  bool isViewerLoading = true;
  bool isSavingBuild = false;
  String? viewerError;
  AccessorySlot selectedSlot = AccessorySlot.hair;
  String selectedCharacterId = characterObjects.first.id;
  final Map<AccessorySlot, String> selectedAccessoryIds = {};

  Character3DObject get selectedCharacter {
    return characterObjects.firstWhere(
      (item) => item.id == selectedCharacterId,
      orElse: () => characterObjects.first,
    );
  }

  @override
  void initState() {
    super.initState();

    selectedAccessoryIds.addAll(selectedCharacter.defaultAccessoryIds);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));

    _startViewer();
  }

  Future<void> _startViewer() async {
    try {
      final origin = await _assetServer.start();

      _controller.setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            if (mounted) {
              setState(() => isViewerLoading = false);
            }
            await _syncCharacterObjectToViewer();
          },
          onWebResourceError: (error) {
            if (mounted) {
              setState(() {
                viewerError = error.description;
                isViewerLoading = false;
              });
            }
          },
        ),
      );

      await _controller.loadRequest(origin.resolve('/character_viewer.html'));
    } catch (error) {
      if (mounted) {
        setState(() {
          viewerError = error.toString();
          isViewerLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _assetServer.stop();
    super.dispose();
  }

  Future<void> _selectAccessory(AccessoryItem item) async {
    final isAlreadySelected = selectedAccessoryIds[item.slot] == item.id;

    setState(() {
      if (isAlreadySelected) {
        selectedAccessoryIds.remove(item.slot);
      } else {
        selectedAccessoryIds[item.slot] = item.id;
      }
    });

    await _syncCharacterObjectToViewer();
  }

  Future<void> _selectCharacter(Character3DObject character) async {
    setState(() {
      selectedCharacterId = character.id;
      selectedAccessoryIds
        ..clear()
        ..addAll(character.defaultAccessoryIds);
    });

    await _syncCharacterObjectToViewer();
  }

  Future<void> _syncCharacterObjectToViewer() async {
    if (viewerError != null) return;

    final config = {
      'id': selectedCharacter.id,
      'name': selectedCharacter.name,
      'base': selectedCharacter.toBaseViewerConfig(),
      'accessories': selectedAccessoryIds.values
          .map(_accessoryById)
          .whereType<AccessoryItem>()
          .map((item) => item.toViewerConfig(characterId: selectedCharacter.id))
          .toList(),
    };

    await _controller.runJavaScript(
      'setCharacterObject(${jsonEncode(config)});',
    );
  }

  AccessoryItem? _accessoryById(String id) {
    for (final item in accessoryItems) {
      if (item.id == id) return item;
    }
    return null;
  }

  Future<void> _rotateLeft() async {
    await _controller.runJavaScript('rotateCharacter(-0.35);');
  }

  Future<void> _rotateRight() async {
    await _controller.runJavaScript('rotateCharacter(0.35);');
  }

  Future<void> _resetView() async {
    await _controller.runJavaScript('resetView();');
  }

  Future<void> _saveCurrentBuild() async {
    if (isSavingBuild) return;

    setState(() => isSavingBuild = true);
    final now = DateTime.now();
    final build = SavedCharacterBuild(
      id: now.microsecondsSinceEpoch.toString(),
      name: '${selectedCharacter.name} ${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}',
      characterId: selectedCharacterId,
      accessoryIdsBySlot: selectedAccessoryIds.map(
        (slot, accessoryId) => MapEntry(slot.key, accessoryId),
      ),
      createdAt: now,
    );

    try {
      await _savedBuildStore.saveBuild(build);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved ${build.name}')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot save character: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => isSavingBuild = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleAccessories = accessoryItems
        .where((item) => item.slot == selectedSlot)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '3D Character Demo',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Character object + accessory GLB preview',
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _resetView,
                    icon: const Icon(
                      Icons.center_focus_strong,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.16),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (isViewerLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondary,
                        ),
                      ),
                    if (viewerError != null)
                      Positioned.fill(
                        child: Container(
                          color: const Color(0xDD09090B),
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Text(
                              'Cannot open 3D viewer:\n$viewerError',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: characterObjects.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final character = characterObjects[index];
                        final selected = character.id == selectedCharacterId;

                        return ChoiceChip(
                          label: Text(character.name),
                          selected: selected,
                          onSelected: (_) => _selectCharacter(character),
                          selectedColor: AppColors.primary,
                          backgroundColor: Colors.white.withValues(alpha: 0.06),
                          labelStyle: TextStyle(
                            color: selected ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  AccessoryCategoryTabs(
                    selectedSlot: selectedSlot,
                    onChanged: (slot) => setState(() => selectedSlot = slot),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 118,
                    child: visibleAccessories.isEmpty
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'No ${selectedSlot.label.toLowerCase()} assets yet.',
                              style: const TextStyle(color: Colors.white54),
                            ),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: visibleAccessories.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final item = visibleAccessories[index];
                              return AccessoryOptionCard(
                                item: item,
                                selected:
                                    selectedAccessoryIds[item.slot] == item.id,
                                onTap: () => _selectAccessory(item),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: isSavingBuild ? null : _saveCurrentBuild,
                          icon: isSavingBuild
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save),
                          label: const Text('Luu nhan vat'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _rotateLeft,
                          icon: const Icon(Icons.rotate_left),
                          label: const Text('Xoay trai'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _rotateRight,
                          icon: const Icon(Icons.rotate_right),
                          label: const Text('Xoay phai'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
