import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidBackground extends StatelessWidget {
  const LiquidBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base
        Container(color: const Color(0xFF070A12)),

        // Bright blobs (no fixed colors? ты просил яркие — я задал, иначе будет уныло)
        const _Blob(
          alignment: Alignment(-1.1, -0.9),
          size: 420,
          color: Color(0xFF2BC0E4),
          opacity: 0.30,
        ),
        const _Blob(
          alignment: Alignment(1.0, -0.4),
          size: 380,
          color: Color(0xFFB94BFF),
          opacity: 0.26,
        ),
        const _Blob(
          alignment: Alignment(-0.2, 1.1),
          size: 460,
          color: Color(0xFFFF4FD8),
          opacity: 0.18,
        ),

        // Blur it like liquid glass
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(color: Colors.transparent),
          ),
        ),

        // Soft grain overlay (optional feel)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.05),
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.04),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  final Alignment alignment;
  final double size;
  final Color color;
  final double opacity;

  const _Blob({
    required this.alignment,
    required this.size,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: opacity),
        ),
      ),
    );
  }
}
