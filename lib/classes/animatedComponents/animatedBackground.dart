import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:pupdoc/classes/style.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
      primaryColors: [
        ColorsPalette.Cian,
        ColorsPalette.DarkCian
      ],
      secondaryColors: [
        ColorsPalette.DarkCian,
        ColorsPalette.Cian
      ],
      child: child,
    );
  }
}
