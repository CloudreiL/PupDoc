import 'package:flutter/material.dart';
import 'package:pupdoc/classes/style.dart';

class AnimatedProgressBar extends StatefulWidget {
  final int currentStep;
  final int totalSteps;

  const AnimatedProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double get _progress => widget.currentStep / widget.totalSteps;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: 0.0, end: _progress).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: _progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: _animation.value,
          minHeight: 5,
          backgroundColor: Color.fromRGBO(69, 123, 196, 0.1),
          valueColor: AlwaysStoppedAnimation<Color>(
            ColorsPalette.DarkCian
          ),
        );
      },
    );
  }
}
