import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';
import 'package:jarve_j/core/constants/jarvis_strings.dart';
import 'package:jarve_j/core/models/jarvis_state.dart';
import 'package:jarve_j/core/models/system_metrics.dart';
import 'package:jarve_j/services/jarvis_brain_service.dart';
import 'package:jarve_j/services/telemetry_service.dart';
import 'package:jarve_j/widgets/jarvis_orb.dart';
import 'package:jarve_j/widgets/status_badge.dart';
import 'package:jarve_j/widgets/system_telemetry_bar.dart';
import 'package:jarve_j/widgets/quick_actions_grid.dart';

class DashboardTab extends StatefulWidget {
  final JarvisBrainService brainService;
  final TelemetryService telemetryService;
  final Function(int targetIndex) onNavigateToTab;

  const DashboardTab({
    super.key,
    required this.brainService,
    required this.telemetryService,
    required this.onNavigateToTab,
  });

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  late Timer _clockTimer;
  DateTime _currentTime = DateTime.now();
  final TextEditingController _promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _promptController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _promptController.text.trim();
    if (text.isNotEmpty) {
      widget.brainService.processUserInput(text);
      _promptController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.brainService,
      builder: (context, _) {
        final currentStatus = widget.brainService.status;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Futuristic Header HUD
                  _buildHeaderHUD(currentStatus),
                  const SizedBox(height: 18),

                  // 2. Center Animated Arc Reactor Orb
                  Center(
                    child: Column(
                      children: [
                        JarvisOrb(
                          status: currentStatus,
                          size: 210,
                          onTap: () {
                            widget.brainService.toggleStatus();
                          },
                        ),
                        const SizedBox(height: 14),
                        Text(
                          currentStatus.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: currentStatus.color,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '(Tap orb to cycle states: READY • LISTEN • THINK • SPEAK)',
                          style: TextStyle(
                            color: JarvisColors.textMuted,
                            fontSize: 10,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 3. Live System Telemetry Bar
                  StreamBuilder<SystemMetrics>(
                    stream: widget.telemetryService.metricsStream,
                    initialData: widget.telemetryService.current,
                    builder: (context, snapshot) {
                      final metrics = snapshot.data ?? SystemMetrics.initial();
                      return SystemTelemetryBar(metrics: metrics);
                    },
                  ),

                  const SizedBox(height: 20),

                  // 4. Quick Command Input Bar
                  _buildCommandInputBar(currentStatus),

                  const SizedBox(height: 20),

                  // 5. Direct Protocols Quick Action Grid
                  QuickActionsGrid(
                    actions: [
                      QuickActionItem(
                        title: 'AI Chat',
                        icon: Icons.chat_bubble_outline_rounded,
                        color: JarvisColors.cyan,
                        onTap: () => widget.onNavigateToTab(1),
                      ),
                      QuickActionItem(
                        title: 'Voice Mode',
                        icon: Icons.mic_none_rounded,
                        color: JarvisColors.green,
                        onTap: () {
                          widget.brainService.setStatus(JarvisStatus.listening);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Voice Mode active — Listening for voice input'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      QuickActionItem(
                        title: 'Study Lab',
                        icon: Icons.school_outlined,
                        color: JarvisColors.amber,
                        onTap: () {
                          widget.brainService.processUserInput('Start Java Study Mode');
                          widget.onNavigateToTab(1);
                        },
                      ),
                      QuickActionItem(
                        title: 'Coding Lab',
                        icon: Icons.code_rounded,
                        color: JarvisColors.purple,
                        onTap: () {
                          widget.brainService.processUserInput('Help me debug code');
                          widget.onNavigateToTab(1);
                        },
                      ),
                      QuickActionItem(
                        title: 'My Tasks',
                        icon: Icons.check_circle_outline_rounded,
                        color: JarvisColors.electricBlue,
                        onTap: () => widget.onNavigateToTab(2),
                      ),
                      QuickActionItem(
                        title: 'Settings',
                        icon: Icons.settings_suggest_outlined,
                        color: JarvisColors.textSecondary,
                        onTap: () => widget.onNavigateToTab(3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderHUD(JarvisStatus status) {
    final timeStr = DateFormat('HH:mm:ss').format(_currentTime);
    final dateStr = DateFormat('EEE, dd MMM yyyy').format(_currentTime).toUpperCase();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: JarvisColors.cyan,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  JarvisStrings.appName,
                  style: TextStyle(
                    color: JarvisColors.cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              dateStr,
              style: const TextStyle(
                color: JarvisColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StatusBadge(status: status),
            const SizedBox(height: 4),
            Text(
              timeStr,
              style: const TextStyle(
                color: JarvisColors.textSecondary,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommandInputBar(JarvisStatus status) {
    return Container(
      decoration: BoxDecoration(
        color: JarvisColors.cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: status == JarvisStatus.thinking ? JarvisColors.amber : JarvisColors.borderLight,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: JarvisColors.cyan.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.terminal_rounded, color: JarvisColors.cyan, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _promptController,
              onSubmitted: (_) => _handleSend(),
              style: const TextStyle(
                color: JarvisColors.textPrimary,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter directive or ask JARVIS...',
                hintStyle: TextStyle(color: JarvisColors.textMuted, fontSize: 13),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, color: JarvisColors.cyan, size: 20),
            onPressed: _handleSend,
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
