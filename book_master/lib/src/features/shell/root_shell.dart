import 'dart:ui';
import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../home/home_screen.dart';
import '../settings/settings_screen.dart';
import '../../widgets/glass_bottom_nav.dart';
import '../../widgets/liquid_background.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    const pages = [
      HomeScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LiquidBackground(),
          SafeArea(
            child: IndexedStack(index: index, children: pages),
          ),

          // Floating glass navbar
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                child: GlassBottomNav(
                  index: index,
                  items: [
                    GlassNavItem(
                      icon: Icons.home_rounded,
                      label: t.t('home_title'),
                    ),
                    GlassNavItem(
                      icon: Icons.tune_rounded,
                      label: t.t('settings_title'),
                    ),
                  ],
                  onChanged: (i) => setState(() => index = i),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
