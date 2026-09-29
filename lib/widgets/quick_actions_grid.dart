import 'package:flutter/material.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';

class QuickActionItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  QuickActionItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class QuickActionsGrid extends StatelessWidget {
  final List<QuickActionItem> actions;

  const QuickActionsGrid({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Text(
            'DIRECT PROTOCOLS',
            style: TextStyle(
              color: JarvisColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final item = actions[index];
            return _buildActionButton(item);
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(QuickActionItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            color: JarvisColors.cardBg.withOpacity(0.55),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: item.color.withOpacity(0.25), width: 1.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.color.withOpacity(0.12),
                ),
                child: Icon(item.icon, size: 22, color: item.color),
              ),
              const SizedBox(height: 6),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: JarvisColors.textPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
