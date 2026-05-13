import 'package:flutter/material.dart';

import '../features/cinematic_vfx/presentation/screens/landing_screen.dart';
import 'app_theme.dart';

class CinematicApp extends StatelessWidget {
  const CinematicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veo 3 VFX',
      theme: AppTheme.darkTheme,
      home: const LandingScreen(),
    );
  }
}
