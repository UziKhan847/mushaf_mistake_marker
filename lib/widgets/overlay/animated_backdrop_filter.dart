import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedBackdropFilter extends StatefulWidget {
  const AnimatedBackdropFilter({super.key, this.controller});

  final AnimationController? controller;

  @override
  State<AnimatedBackdropFilter> createState() => _AnimatedBackdropFilterState();
}

class _AnimatedBackdropFilterState extends State<AnimatedBackdropFilter> {
  Animation<double>? opacity;
  Animation<double>? blur;

  @override
  void initState() {
    super.initState();

    final animCtrl = widget.controller;

    if (animCtrl != null) {
      opacity = Tween<double>(begin: 0, end: 0.16)
          .chain(CurveTween(curve: Interval(0, 0.55, curve: Curves.easeOut)))
          .animate(animCtrl);

      blur = Tween<double>(
        begin: 0,
        end: 1,
      ).chain(CurveTween(curve: Curves.easeOut)).animate(animCtrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: SizedBox.expand(
          child: ColoredBox(color: Colors.black.withAlpha(40)),
        ),
      );
    }

    return AnimatedBuilder(
      animation: widget.controller!,
      builder: (context, child) {
        return FadeTransition(
          opacity: opacity!,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur!.value, sigmaY: blur!.value),
            child: child,
          ),
        );
      },
      child: SizedBox.expand(child: ColoredBox(color: Colors.black)),
    );
  }
}
