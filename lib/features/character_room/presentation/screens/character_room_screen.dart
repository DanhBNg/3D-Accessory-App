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

  String selectedCharacter = 'female';
  bool isViewerLoading = true;
  String? viewerError;

  static const characters = [
    _RoomCharacter(id: 'female', label: 'Female'),
    _RoomCharacter(id: 'male', label: 'Male'),
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
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: _buildCharacterSelector(),
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
}

class _RoomCharacter {
  final String id;
  final String label;

  const _RoomCharacter({required this.id, required this.label});
}
