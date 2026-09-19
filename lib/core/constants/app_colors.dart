import 'package:flutter/material.dart';

/// Centralized color palette.
/// Kept separate from [AppTheme] so widgets can reference semantic
/// colors (e.g. AppColors.profitGreen) without pulling in ThemeData.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF1B1F3B); // deep navy
  static const Color primaryLight = Color(0xFF2E3465);
  static const Color accent = Color(0xFF5B6CFF); // indigo accent
  static const Color accentSoft = Color(0xFFEDEEFF);

  // Surfaces
  static const Color background = Color(0xFFF7F8FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F2F8);

  // Text
  static const Color textPrimary = Color(0xFF14162B);
  static const Color textSecondary = Color(0xFF6B6F8D);
  static const Color textDisabled = Color(0xFFAEB1C7);

  // Semantic
  static const Color profitGreen = Color(0xFF17A673);
  static const Color lossRed = Color(0xFFE4573D);
  static const Color warningAmber = Color(0xFFF5A524);

  // Borders / dividers
  static const Color divider = Color(0xFFE7E8F2);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B1F3B), Color(0xFF383F78)],
  );
}
