import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../character_3d/data/accessory_mock_data.dart';
import '../../../character_3d/data/character_object_mock_data.dart';
import '../../../character_3d/data/saved_character_build_store.dart';
import '../../../character_3d/domain/entities/accessory_item.dart';
import '../../../character_3d/domain/entities/character_3d_object.dart';
import '../../../character_3d/domain/entities/saved_character_build.dart';
import '../../../character_3d/web/local_3d_server.dart';

class CharacterRoomScreen extends StatefulWidget {
  const CharacterRoomScreen({super.key});

  @override
  State<CharacterRoomScreen> createState() => _CharacterRoomScreenState();
}

class _CharacterRoomScreenState extends State<CharacterRoomScreen> {
  final _assetServer = Local3DAssetServer();
  final _savedBuildStore = SavedCharacterBuildStore();
  late final WebViewController _controller;

  List<SavedCharacterBuild> savedBuilds = [];
  bool isLoadingBuilds = true;
  String? selectedBuildId;
  String selectedCharacter = characterObjects.first.id;
  String selectedAnimation = 'idle';
  bool isViewerLoading = true;
  String? viewerError;

  static const animations = [
    _RoomAnimation(
      id: 'idle',
      label: 'Idle',
      url: '/models/animations/breathing_idle.glb',
    ),
    _RoomAnimation(
      id: 'jumping_down',
      label: 'Jumping Down',
      url: '/models/animations/jumping_down.glb',
    ),
    _RoomAnimation(
      id: 'spin',
      label: 'Spin',
      url: '/models/animations/spin_act.glb',
    ),
    _RoomAnimation(
      id: 'hip_hop',
      label: 'Hip Hop Dance',
      url: '/models/animations/hip_hop_dancing.glb',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));

    _startViewer();
    _loadSavedBuilds();
  }

  Future<void> _startViewer() async {
    try {
      final origin = await _assetServer.start();

      _controller.setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => isViewerLoading = false);
            }
            _syncSelectedBuildToViewer();
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

      await _controller.loadRequest(
        origin.resolve('/character_room_viewer.html'),
      );
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

  Future<void> _loadSavedBuilds() async {
    try {
      final builds = await _savedBuildStore.loadBuilds();
      if (!mounted) return;

      setState(() {
        savedBuilds = builds;
        selectedBuildId = builds.isEmpty ? null : builds.first.id;
        selectedCharacter = builds.isEmpty
            ? characterObjects.first.id
            : builds.first.characterId;
        isLoadingBuilds = false;
      });

      await _syncSelectedBuildToViewer();
    } catch (error) {
      if (!mounted) return;
      setState(() => isLoadingBuilds = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot load saved characters: $error')),
      );
    }
  }

  Future<void> _selectCharacter(String characterId) async {
    setState(() {
      selectedBuildId = null;
      selectedCharacter = characterId;
    });
    await _syncSelectedBuildToViewer();
  }

  Future<void> _selectSavedBuild(SavedCharacterBuild build) async {
    setState(() {
      selectedBuildId = build.id;
      selectedCharacter = build.characterId;
    });
    await _syncSelectedBuildToViewer();
  }

  Future<void> _selectAnimation(String animationId) async {
    setState(() => selectedAnimation = animationId);
    final animUrl = animations.firstWhere((a) => a.id == animationId).url;
    await _controller.runJavaScript('playExternalAnimation("$animUrl");');
  }

  Future<void> _resetCamera() async {
    await _controller.runJavaScript('location.reload();');
  }

  Future<void> _syncSelectedBuildToViewer() async {
    if (viewerError != null || isViewerLoading) return;

    final character = _characterById(selectedCharacter);
    final build = _selectedBuild;
    final selectedAccessoryIds = build?.accessoryIdsBySlot.values ?? const [];
    final config = {
      'id': build?.id ?? character.id,
      'name': build?.name ?? character.name,
      'base': character.toBaseViewerConfig(),
      'accessories': selectedAccessoryIds
          .map(_accessoryById)
          .whereType<AccessoryItem>()
          .map((item) => item.toViewerConfig(characterId: character.id))
          .toList(),
    };

    await _controller.runJavaScript(
      'setCharacterObject(${jsonEncode(config)});',
    );

    final animUrl = animations.firstWhere((a) => a.id == selectedAnimation).url;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _controller.runJavaScript('playExternalAnimation("$animUrl");');
      }
    });
  }

  SavedCharacterBuild? get _selectedBuild {
    final id = selectedBuildId;
    if (id == null) return null;
    for (final build in savedBuilds) {
      if (build.id == id) return build;
    }
    return null;
  }

  Character3DObject _characterById(String id) {
    return characterObjects.firstWhere(
      (item) => item.id == id,
      orElse: () => characterObjects.first,
    );
  }

  AccessoryItem? _accessoryById(String id) {
    for (final item in accessoryItems) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final selectedLabel =
        _selectedBuild?.name ?? _characterById(selectedCharacter).name;

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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Character Room',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$selectedLabel character in room',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _resetCamera,
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
                              'Cannot open character room:\n$viewerError',
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
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
              child: _buildCharacterSelector(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: _buildAnimationSelector(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterSelector() {
    if (isLoadingBuilds) {
      return const SizedBox(
        height: 42,
        child: Align(
          alignment: Alignment.centerLeft,
          child: CircularProgressIndicator(color: AppColors.secondary),
        ),
      );
    }

    if (savedBuilds.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saved Characters',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: savedBuilds.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final build = savedBuilds[index];
                final selected = build.id == selectedBuildId;

                return ChoiceChip(
                  label: Text(build.name),
                  selected: selected,
                  onSelected: (_) => _selectSavedBuild(build),
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
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Character',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: characterObjects.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final character = characterObjects[index];
              final selected = character.id == selectedCharacter;

              return ChoiceChip(
                label: Text(character.name),
                selected: selected,
                onSelected: (_) => _selectCharacter(character.id),
                selectedColor: AppColors.primary,
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnimationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Action',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: animations.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final animation = animations[index];
              final selected = animation.id == selectedAnimation;

              return ChoiceChip(
                label: Text(animation.label),
                selected: selected,
                onSelected: (_) => _selectAnimation(animation.id),
                selectedColor: AppColors.secondary,
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                labelStyle: TextStyle(
                  color: selected ? Colors.black : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RoomAnimation {
  final String id;
  final String label;
  final String url;

  const _RoomAnimation({
    required this.id,
    required this.label,
    required this.url,
  });
}
