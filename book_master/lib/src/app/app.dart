import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/vm/vm_provider.dart';
import '../features/shell/root_shell.dart';
import '../features/settings/settings_view_model.dart';
import 'localization/app_localizations.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  final SettingsViewModel settingsVm;
  const App({super.key, required this.settingsVm});

  @override
  Widget build(BuildContext context) {
    return VmProvider<SettingsViewModel>(
      viewModel: settingsVm,
      child: VmBuilder<SettingsViewModel>(
        builder: (context, vm) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Liquid Glass',
            theme: AppTheme.light(),
            locale: vm.locale,
            supportedLocales: const [
              Locale('ru'),
              Locale('uz'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const RootShell(),
          );
        },
      ),
    );
  }
}
