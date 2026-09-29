import 'package:flutter/material.dart';

class JarvisColors {
  // Backgrounds
  static const Color background = Color(0xFF050811);
  static const Color backgroundSurface = Color(0xFF0B101F);
  static const Color cardBg = Color(0xFF0F172A);
  static const Color glassFill = Color(0x1400F0FF);

  // Futuristic Neons
  static const Color cyan = Color(0xFF00F0FF);
  static const Color deepCyan = Color(0xFF0099B8);
  static const Color electricBlue = Color(0xFF0072FF);
  static const Color cobalt = Color(0xFF1E3A8A);
  
  // State Neons
  static const Color green = Color(0xFF00FFA3);
  static const Color amber = Color(0xFFFFB800);
  static const Color red = Color(0xFFFF2A6D);
  static const Color purple = Color(0xFF9D4EDD);

  // Borders & Accents
  static const Color borderLight = Color(0x3300F0FF);
  static const Color borderSubtle = Color(0x1A00F0FF);
  static const Color divider = Color(0x221E293B);

  // Typography
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textCyan = Color(0xFF38BDF8);

  // Gradients
  static const LinearGradient arcReactorGradient = LinearGradient(
    colors: [Color(0xFF00F0FF), Color(0xFF0072FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardBorderGradient = LinearGradient(
    colors: [Color(0x6600F0FF), Color(0x110072FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
