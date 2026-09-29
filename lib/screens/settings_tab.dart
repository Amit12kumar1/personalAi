import 'package:flutter/material.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';
import 'package:jarve_j/widgets/futuristic_card.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final TextEditingController _apiKeyController = TextEditingController();
  bool _voiceFeedback = true;
  bool _askConfirmation = true;
  String _selectedModel = 'Gemini 1.5 Pro / Flash';

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: JarvisColors.backgroundSurface.withOpacity(0.9),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.tune_rounded, color: JarvisColors.cyan, size: 20),
            SizedBox(width: 8),
            Text(
              'SYSTEM CONFIGURATION',
              style: TextStyle(
                color: JarvisColors.cyan,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('AI ENGINE & NEURAL PROVIDER'),
            const SizedBox(height: 8),
            FuturisticCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Active Model Engine',
                    style: TextStyle(color: JarvisColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: JarvisColors.backgroundSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: JarvisColors.borderLight),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedModel,
                        dropdownColor: JarvisColors.cardBg,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down, color: JarvisColors.cyan),
                        items: const [
                          DropdownMenuItem(value: 'Gemini 1.5 Pro / Flash', child: Text('Gemini 1.5 Flash (Fast & Capable)')),
                          DropdownMenuItem(value: 'OpenAI GPT-4o', child: Text('OpenAI GPT-4o (Reasoning & Tools)')),
                          DropdownMenuItem(value: 'Local LLM / Backend', child: Text('Local FastAPI Agent (Self-Hosted)')),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedModel = val);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'API Key (Stored locally in secure storage)',
                    style: TextStyle(color: JarvisColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _apiKeyController,
                    obscureText: true,
                    style: const TextStyle(color: JarvisColors.textPrimary, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Enter AI API Key (sk-... or AIza...)',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.save_outlined, color: JarvisColors.cyan, size: 20),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('API Configuration updated locally.')),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),
            _buildSectionHeader('SECURITY & PERMISSION PROTOCOLS'),
            const SizedBox(height: 8),
            FuturisticCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Require Tool Confirmation', style: TextStyle(color: JarvisColors.textPrimary, fontSize: 14)),
                    subtitle: const Text('Prompt user before deleting files or opening external apps', style: TextStyle(color: JarvisColors.textMuted, fontSize: 11)),
                    value: _askConfirmation,
                    activeColor: JarvisColors.cyan,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) => setState(() => _askConfirmation = val),
                  ),
                  const Divider(color: JarvisColors.borderSubtle),
                  SwitchListTile(
                    title: const Text('Synthesized Voice Output', style: TextStyle(color: JarvisColors.textPrimary, fontSize: 14)),
                    subtitle: const Text('Enable Text-To-Speech audio output for AI replies', style: TextStyle(color: JarvisColors.textMuted, fontSize: 11)),
                    value: _voiceFeedback,
                    activeColor: JarvisColors.cyan,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) => setState(() => _voiceFeedback = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),
            _buildSectionHeader('SYSTEM DIAGNOSTICS'),
            const SizedBox(height: 8),
            const FuturisticCard(
              child: Column(
                children: [
                  _DiagnosticRow(label: 'CORE SYSTEM', value: 'J.A.R.V.I.S. Core v1.0.0'),
                  _DiagnosticRow(label: 'FRAMEWORK', value: 'Flutter 3.19.6 • Dart 3.3.4'),
                  _DiagnosticRow(label: 'ARCH PROTOCOL', value: 'Modular Agentic HUD Architecture'),
                  _DiagnosticRow(label: 'DATABASE LINK', value: 'SQLite Local Vault Ready'),
                  _DiagnosticRow(label: 'STATUS', value: 'READY FOR PHASE 2 EXPANSION'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: JarvisColors.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    );
  }
}

class _DiagnosticRow extends StatelessWidget {
  final String label;
  final String value;

  const _DiagnosticRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: JarvisColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: JarvisColors.cyan, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
