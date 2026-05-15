import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../character_3d/web/local_3d_server.dart';

class CharacterRoomScreen extends StatefulWidget {
  const CharacterRoomScreen({super.key});

  @override
  State<CharacterRoomScreen> createState() => _CharacterRoomScreenState();
}

class _CharacterRoomScreenState extends State<CharacterRoomScreen> {
  final _assetServer = Local3DAssetServer();
  late final WebViewController _controller;

  String selectedCharacter = 'character1';
  String selectedAnimation = 'idle';
  bool isViewerLoading = true;
  String? viewerError;

  static const characters = [
    _RoomCharacter(id: 'character1', label: 'Character 1'),
    _RoomCharacter(id: 'character2', label: 'Character 2'),
    _RoomCharacter(id: 'character3', label: 'Character 3'),
  ];

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

  Future<void> _selectCharacter(String characterId) async {
    setState(() => selectedCharacter = characterId);
    await _controller.runJavaScript('setCharacter("$characterId");');

    // When switching character, re-apply the selected animation
    final animUrl = animations.firstWhere((a) => a.id == selectedAnimation).url;
    if (animUrl.isNotEmpty) {
      // Need a slight delay to let character load, but in reality we should await the JS promise.
      // Since runJavaScript returns immediately, we use a small delay for now.
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _controller.runJavaScript('playExternalAnimation("$animUrl");');
        }
      });
    }
  }

  Future<void> _selectAnimation(String animationId) async {
    setState(() => selectedAnimation = animationId);
    final animUrl = animations.firstWhere((a) => a.id == animationId).url;
    await _controller.runJavaScript('playExternalAnimation("$animUrl");');
  }

  Future<void> _resetCamera() async {
    await _controller.runJavaScript('location.reload();');
  }

  @override
  Widget build(BuildContext context) {
    final selectedLabel = characters
        .firstWhere((item) => item.id == selectedCharacter)
        .label;

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
            itemCount: characters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final character = characters[index];
              final selected = character.id == selectedCharacter;

              return ChoiceChip(
                label: Text(character.label),
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

class _RoomCharacter {
  final String id;
  final String label;

  const _RoomCharacter({required this.id, required this.label});
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
