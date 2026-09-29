import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:jarve_j/core/models/jarvis_state.dart';

class JarvisOrb extends StatefulWidget {
  final JarvisStatus status;
  final VoidCallback? onTap;
  final double size;

  const JarvisOrb({
    super.key,
    required this.status,
    this.onTap,
    this.size = 220,
  });

  @override
  State<JarvisOrb> createState() => _JarvisOrbState();
}

class _JarvisOrbState extends State<JarvisOrb> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant JarvisOrb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      if (widget.status == JarvisStatus.thinking) {
        _rotationController.duration = const Duration(seconds: 4);
        _rotationController.repeat();
      } else if (widget.status == JarvisStatus.speaking) {
        _pulseController.duration = const Duration(milliseconds: 800);
        _pulseController.repeat(reverse: true);
      } else {
        _rotationController.duration = const Duration(seconds: 12);
        _rotationController.repeat();
        _pulseController.duration = const Duration(milliseconds: 1800);
        _pulseController.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateColor = widget.status.color;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([_rotationController, _pulseAnimation]),
        builder: (context, child) {
          final scale = _pulseAnimation.value;
          final angle = _rotationController.value * 2 * math.pi;

          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer Radial Atmosphere Glow
                Container(
                  width: widget.size * scale,
                  height: widget.size * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        stateColor.withOpacity(0.28),
                        stateColor.withOpacity(0.08),
                        Colors.transparent,
                      ],
                      stops: const [0.2, 0.6, 1.0],
                    ),
                  ),
                ),

                // Custom Sci-Fi Arc Reactor Rings
                CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _ArcReactorPainter(
                    angle: angle,
                    color: stateColor,
                    status: widget.status,
                  ),
                ),

                // Central Core Glow & Icon
                Container(
                  width: widget.size * 0.38 * scale,
                  height: widget.size * 0.38 * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white,
                        stateColor,
                        stateColor.withOpacity(0.4),
                      ],
                      stops: const [0.1, 0.6, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: stateColor.withOpacity(0.8),
                        blurRadius: 28 * scale,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _getStatusIcon(widget.status),
                      color: Colors.black.withOpacity(0.85),
                      size: widget.size * 0.16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getStatusIcon(JarvisStatus status) {
    switch (status) {
      case JarvisStatus.idle:
        return Icons.power_settings_new;
      case JarvisStatus.listening:
        return Icons.mic;
      case JarvisStatus.thinking:
        return Icons.auto_awesome;
      case JarvisStatus.speaking:
        return Icons.graphic_eq;
      case JarvisStatus.error:
        return Icons.warning_amber_rounded;
    }
  }
}

class _ArcReactorPainter extends CustomPainter {
  final double angle;
  final Color color;
  final JarvisStatus status;

  _ArcReactorPainter({
    required this.angle,
    required this.color,
    required this.status,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Outer Thin Orbit Ring
    final outerRingPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius * 0.94, outerRingPaint);

    // 2. Rotating Segmented Arc Ring (Clockwise)
    final segmentedArcPaint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    const segmentCount = 6;
    const sweepAngle = (2 * math.pi / segmentCount) * 0.55;

    for (int i = 0; i < segmentCount; i++) {
      final startAngle = angle + (i * 2 * math.pi / segmentCount);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.82),
        startAngle,
        sweepAngle,
        false,
        segmentedArcPaint,
      );
    }

    // 3. Counter-Rotating Inner Dotted/Notched Ring
    final innerNotchPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final reverseAngle = -angle * 1.5;
    const notchCount = 12;
    for (int i = 0; i < notchCount; i++) {
      final currentAngle = reverseAngle + (i * 2 * math.pi / notchCount);
      final r1 = radius * 0.64;
      final r2 = radius * 0.70;

      final p1 = Offset(center.dx + r1 * math.cos(currentAngle), center.dy + r1 * math.sin(currentAngle));
      final p2 = Offset(center.dx + r2 * math.cos(currentAngle), center.dy + r2 * math.sin(currentAngle));
      canvas.drawLine(p1, p2, innerNotchPaint);
    }

    // 4. Middle Core Border Ring
    final coreBorderPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius * 0.50, coreBorderPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcReactorPainter oldDelegate) {
    return oldDelegate.angle != angle || oldDelegate.color != color || oldDelegate.status != status;
  }
}
