import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
      primaryColors: const [
        Color.fromRGBO(109, 220, 225, 1.0),
        Color.fromRGBO(69, 123, 196, 1.0),
      ],
      secondaryColors: const [
        Color.fromRGBO(69, 123, 196, 1.0),
        Color.fromRGBO(109, 220, 225, 1.0),
      ],
      child: child,
    );
  }
}
