import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/theme/theme_definitions.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

extension ThemeDataExtension on ResponsiveThemeData {
  ScreenType getScreenType(double width) {
    if (width < 600) {
      return ScreenType.compact;
    } else if (width >= 600 && width < 840) {
      return ScreenType.medium;
    } else if (width >= 840 && width < 1200) {
      return ScreenType.expanded;
    } else if (width >= 1200 && width < 1800) {
      return ScreenType.large;
    } else {
      return ScreenType.extralarge;
    }
  }

  T valueByScreenType<T>(
    T compact,
    T medium,
    T extralarge,
  ) {
    switch (screenType) {
      case ScreenType.compact:
        return compact;
      case ScreenType.medium:
        return medium;
      default:
        return extralarge;
    }
  }

  T valueByScreenTypeScaled<T>(T value, double factor) {
    try {
      final val = value as dynamic;
      return valueByScreenType<T>(
        val * (1 - factor),
        val,
        val * (1 + factor),
      );
    } catch (e) {
      if (kDebugMode) {
        throw Exception("Value must be num type : $e");
      }
      return value;
    }
  }
}
