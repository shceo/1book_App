import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class ArViewModel extends ChangeNotifier {
  CameraController? _controller;
  CameraController? get controller => _controller;

  bool _isReady = false;
  bool get isReady => _isReady;

  String? _error;
  String? get error => _error;

  Future<void> init() async {
    try {
      final cams = await availableCameras();
      if (cams.isEmpty) {
        _error = 'No cameras found';
        notifyListeners();
        return;
      }

      final back = cams.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cams.first,
      );

      _controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await _controller!.initialize();
      _isReady = true;
    } catch (e) {
      _error = e.toString();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
