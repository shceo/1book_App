import 'package:flutter/material.dart';

class VmProvider<T extends ChangeNotifier> extends InheritedNotifier<T> {
  const VmProvider({
    super.key,
    required T viewModel,
    required super.child,
  }) : super(notifier: viewModel);

  static T of<T extends ChangeNotifier>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<VmProvider<T>>();
    if (provider == null) {
      throw Exception('VmProvider<$T> not found in widget tree');
    }
    final vm = provider.notifier;
    if (vm == null) throw Exception('VmProvider<$T> has null notifier');
    return vm;
  }
}

class VmBuilder<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T vm) builder;
  const VmBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final vm = VmProvider.of<T>(context);
    return AnimatedBuilder(
      animation: vm,
      builder: (context, _) => builder(context, vm),
    );
  }
}
