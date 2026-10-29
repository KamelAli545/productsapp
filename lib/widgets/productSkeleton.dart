import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  // base: the pale pink used by the category circles
  static const _block = Color(0xFFFCE4EA);
  // highlight: white sweep, visible on the pale pink
  static const _shine = Color(0xFFFFFFFF);

  Widget _bar(double widthFactor, double height) => FractionallySizedBox(
    widthFactor: widthFactor,
    child: Container(
      height: height,
      decoration: BoxDecoration(
        color: _block,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 2 / 3,
          child: Container(
            decoration: BoxDecoration(
              color: _block,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _bar(0.8, 12),
        const SizedBox(height: 6),
        _bar(0.4, 10),
      ],
    )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(duration: 1200.ms, color: _shine);
  }
}