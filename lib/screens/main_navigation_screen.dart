import 'package:flutter/material.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';
import 'package:jarve_j/services/jarvis_brain_service.dart';
import 'package:jarve_j/services/telemetry_service.dart';
import 'package:jarve_j/screens/dashboard_tab.dart';
import 'package:jarve_j/screens/chat_tab.dart';
import 'package:jarve_j/screens/tasks_tab.dart';
import 'package:jarve_j/screens/settings_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late final JarvisBrainService _brainService;
  late final TelemetryService _telemetryService;

  @override
  void initState() {
    super.initState();
    _brainService = JarvisBrainService();
    _telemetryService = TelemetryService()..start();
  }

  @override
  void dispose() {
    _brainService.dispose();
    _telemetryService.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      DashboardTab(
        brainService: _brainService,
        telemetryService: _telemetryService,
        onNavigateToTab: _onTabChanged,
      ),
      ChatTab(brainService: _brainService),
      const TasksTab(),
      const SettingsTab(),
    ];

    return Scaffold(
      backgroundColor: JarvisColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: JarvisColors.backgroundSurface,
          border: Border(
            top: BorderSide(color: JarvisColors.borderSubtle, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabChanged,
          backgroundColor: Colors.transparent,
          selectedItemColor: JarvisColors.cyan,
          unselectedItemColor: JarvisColors.textMuted,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.0),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.blur_on_rounded),
              activeIcon: Icon(Icons.blur_on_rounded, color: JarvisColors.cyan),
              label: 'HUD',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              activeIcon: Icon(Icons.chat_bubble_rounded, color: JarvisColors.cyan),
              label: 'CHAT',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline_rounded),
              activeIcon: Icon(Icons.check_circle_rounded, color: JarvisColors.cyan),
              label: 'TASKS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tune_rounded),
              activeIcon: Icon(Icons.tune_rounded, color: JarvisColors.cyan),
              label: 'CONFIG',
            ),
          ],
        ),
      ),
    );
  }
}
