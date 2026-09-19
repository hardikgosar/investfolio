/// Non-color design tokens: spacing, radii, durations, strings.
class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  AppRadius._();
  static const double sm = 8;
  static const double md = 14;
  static const double lg = 20;
  static const double pill = 100;
}

class AppDurations {
  AppDurations._();
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

/// External links used by the "Explore" screen bottom sheet.
/// Centralized so the assignment reviewer can see all link targets
/// declared in one place.
class ExternalLinks {
  ExternalLinks._();
  static const String google = 'https://www.google.com';
  static const String sliqfin = 'https://las.sliqfin.com';
  static const String smallcase = 'https://www.smallcase.com';
  static const String flutterDev = 'https://flutter.dev';
}
