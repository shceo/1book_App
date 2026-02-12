import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../core/vm/vm_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/liquid_button.dart';
import 'ar_view_model.dart';

class ArScreen extends StatefulWidget {
  final String code;
  const ArScreen({super.key, required this.code});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  late final ArViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = ArViewModel();
    vm.init();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return VmProvider<ArViewModel>(
      viewModel: vm,
      child: VmBuilder<ArViewModel>(
        builder: (context, vm) {
          final err = vm.error;
          final ctrl = vm.controller;

          return Scaffold(
            body: Stack(
              children: [
                // Camera preview / background
                Positioned.fill(
                  child: _buildCameraLayer(vm, ctrl),
                ),

                // Top glass header
                Positioned(
                  left: 16,
                  right: 16,
                  top: MediaQuery.of(context).padding.top + 14,
                  child: _TopGlassBar(
                    title: 'AR',
                    subtitle: '${t.t('enter_code_title')}: ${widget.code}',
                    onBack: () => Navigator.of(context).pop(),
                  ),
                ),

                // Center hint/error
                if (err != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GlassCard(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Ошибка камеры',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              err,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            LiquidButton(
                              text: 'Назад',
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Bottom controls (glass)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: _BottomGlassControls(
                    enabled: vm.isReady && err == null,
                    onOpenUnityLater: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Дальше подключим сюда Unity AR (ARCore).'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCameraLayer(ArViewModel vm, CameraController? ctrl) {
    if (!vm.isReady || ctrl == null) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF070A12),
              Color(0xFF0C1020),
              Color(0xFF070A12),
            ],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return CameraPreview(ctrl);
  }
}

class _TopGlassBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _TopGlassBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.14)),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.75),
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white.withOpacity(0.10),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.center_focus_strong_rounded,
                        size: 18, color: Colors.white.withOpacity(0.9)),
                    const SizedBox(width: 6),
                    Text(
                      'Preview',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomGlassControls extends StatelessWidget {
  final bool enabled;
  final VoidCallback onOpenUnityLater;

  const _BottomGlassControls({
    required this.enabled,
    required this.onOpenUnityLater,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.14)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _chip('Move', Icons.open_with_rounded),
                  const SizedBox(width: 8),
                  _chip('Lock', Icons.lock_rounded),
                  const SizedBox(width: 8),
                  _chip('Reset', Icons.refresh_rounded),
                  const Spacer(),
                  _chip('ARCore', Icons.auto_awesome_rounded),
                ],
              ),
              const SizedBox(height: 10),
              LiquidButton(
                text: 'Открыть AR (Unity)',
                enabled: enabled,
                onTap: onOpenUnityLater,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withOpacity(0.10),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white.withOpacity(0.9)),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
