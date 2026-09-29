import 'package:flutter/material.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';
import 'package:jarve_j/core/models/system_metrics.dart';

class SystemTelemetryBar extends StatelessWidget {
  final SystemMetrics metrics;

  const SystemTelemetryBar({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: JarvisColors.cardBg.withOpacity(0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: JarvisColors.borderSubtle),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricItem(
            icon: Icons.memory,
            label: 'CPU',
            value: '${metrics.cpuUsage.toStringAsFixed(1)}%',
            color: metrics.cpuUsage > 80 ? JarvisColors.red : JarvisColors.cyan,
            progress: metrics.cpuUsage / 100,
          ),
          _buildDivider(),
          _buildMetricItem(
            icon: Icons.storage_rounded,
            label: 'RAM',
            value: '${metrics.ramUsage.toStringAsFixed(1)}%',
            color: metrics.ramUsage > 85 ? JarvisColors.amber : JarvisColors.electricBlue,
            progress: metrics.ramUsage / 100,
          ),
          _buildDivider(),
          _buildMetricItem(
            icon: metrics.isCharging ? Icons.battery_charging_full : Icons.battery_std,
            label: 'PWR',
            value: '${metrics.batteryLevel}%',
            color: metrics.batteryLevel < 20 ? JarvisColors.red : JarvisColors.green,
            progress: metrics.batteryLevel / 100,
          ),
          _buildDivider(),
          _buildMetricItem(
            icon: Icons.wifi,
            label: 'PING',
            value: '${metrics.latencyMs}ms',
            color: JarvisColors.green,
            progress: (metrics.latencyMs / 100).clamp(0.0, 1.0),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 28,
      width: 1,
      color: JarvisColors.borderSubtle,
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required double progress,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: JarvisColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 36,
          height: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }
}
