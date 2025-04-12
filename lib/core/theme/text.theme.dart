import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme() {
  TextTheme baseTextTheme = const TextTheme();
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme('Roboto', baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme('Roboto', baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    displayLarge: bodyTextTheme.bodyLarge,
    displayMedium: bodyTextTheme.bodyMedium,
    displaySmall: bodyTextTheme.bodySmall,
    headlineLarge: bodyTextTheme.bodyLarge,
    headlineMedium: bodyTextTheme.bodyMedium,
    headlineSmall: bodyTextTheme.bodySmall,
    titleLarge: bodyTextTheme.bodyLarge,
    titleMedium: bodyTextTheme.bodyMedium,
    titleSmall: bodyTextTheme.bodySmall,
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
