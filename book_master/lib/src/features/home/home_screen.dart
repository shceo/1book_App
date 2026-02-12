import 'package:flutter/material.dart';
import 'package:liquid_glass_mvvm/src/features/ar/ar_screen.dart';

import '../../app/localization/app_localizations.dart';
import '../../core/vm/vm_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/liquid_button.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return VmProvider<HomeViewModel>(
      viewModel: HomeViewModel(),
      child: VmBuilder<HomeViewModel>(
        builder: (context, vm) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.t('enter_code_title'),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  t.t('enter_code_hint'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.65),
                      ),
                ),
                const Spacer(),
                GlassCard(
                  child: Column(
                    children: [
                      TextField(
                        onChanged: vm.setCode,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          hintText: t.t('enter_code_hint'),
                          prefixIcon: const Icon(Icons.qr_code_2_rounded),
                        ),
                      ),
                      const SizedBox(height: 14),
                      LiquidButton(
                        text: t.t('continue_btn'),
                        enabled: vm.canContinue,
                        onTap: () {
                          final code = vm.code.trim();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ArScreen(code: code),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
