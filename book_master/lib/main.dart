import 'package:flutter/material.dart';
import 'src/app/app.dart';
import 'src/features/settings/settings_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsVm = SettingsViewModel();
  await settingsVm.load();

  runApp(App(settingsVm: settingsVm));
}
