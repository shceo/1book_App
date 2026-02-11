import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../core/vm/vm_provider.dart';
import '../../widgets/glass_card.dart';
import 'settings_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.t('settings_title'),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 18),

          GlassCard(
            child: VmBuilder<SettingsViewModel>(
              builder: (context, vm) {
                final lang = vm.locale.languageCode;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.t('language'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: CupertinoSlidingSegmentedControl<String>(
                            groupValue: lang,
                            children: {
                              'ru': _seg(t.t('lang_ru')),
                              'uz': _seg(t.t('lang_uz')),
                              'en': _seg(t.t('lang_en')),
                            },
                            onValueChanged: (v) {
                              if (v == null) return;
                              vm.setLocale(Locale(v));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _seg(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}
