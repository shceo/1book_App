import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  String _code = '';
  String get code => _code;

  bool get canContinue => _code.trim().length >= 3;

  void setCode(String v) {
    _code = v;
    notifyListeners();
  }
}
