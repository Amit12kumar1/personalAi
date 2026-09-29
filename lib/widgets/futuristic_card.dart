import 'package:flutter/material.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';

class FuturisticCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final VoidCallback? onTap;

  const FuturisticCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: JarvisColors.cardBg.withOpacity(0.75),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor ?? JarvisColors.borderLight,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: (borderColor ?? JarvisColors.cyan).withOpacity(0.06),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
