import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/jarvis_colors.dart';

class JarvisTheme {
  static ThemeData get darkTheme {
    final baseTextTheme = Typography.material2021().white;

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: JarvisColors.background,
      primaryColor: JarvisColors.cyan,
      colorScheme: const ColorScheme.dark(
        primary: JarvisColors.cyan,
        secondary: JarvisColors.electricBlue,
        surface: JarvisColors.cardBg,
        error: JarvisColors.red,
        onPrimary: Colors.black,
        onSurface: JarvisColors.textPrimary,
      ),
      textTheme: GoogleFonts.rajdhaniTextTheme(baseTextTheme).copyWith(
        displayLarge: GoogleFonts.orbitron(
          color: JarvisColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
        headlineMedium: GoogleFonts.orbitron(
          color: JarvisColors.cyan,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
        titleMedium: GoogleFonts.rajdhani(
          color: JarvisColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
        bodyLarge: GoogleFonts.rajdhani(
          color: JarvisColors.textPrimary,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
        bodyMedium: GoogleFonts.rajdhani(
          color: JarvisColors.textSecondary,
          fontSize: 14,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardTheme(
        color: JarvisColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: JarvisColors.borderLight, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: JarvisColors.cardBg,
        hintStyle: const TextStyle(color: JarvisColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: JarvisColors.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: JarvisColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: JarvisColors.cyan, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: JarvisColors.backgroundSurface,
        selectedItemColor: JarvisColors.cyan,
        unselectedItemColor: JarvisColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
