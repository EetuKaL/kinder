import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5b00cd),
      surfaceTint: Color(0xff7413fd),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff761aff),
      onPrimaryContainer: Color(0xffe4d5ff),
      secondary: Color(0xff6b4ab2),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb290fd),
      onSecondaryContainer: Color(0xff45208a),
      tertiary: Color(0xff880078),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb1009d),
      onTertiaryContainer: Color(0xffffceee),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff1d1a25),
      onSurfaceVariant: Color(0xff4a4457),
      outline: Color(0xff7b7488),
      outlineVariant: Color(0xffccc2da),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332e3b),
      inversePrimary: Color(0xffd1bcff),
      primaryFixed: Color(0xffeaddff),
      onPrimaryFixed: Color(0xff24005b),
      primaryFixedDim: Color(0xffd1bcff),
      onPrimaryFixedVariant: Color(0xff5800c8),
      secondaryFixed: Color(0xffeaddff),
      onSecondaryFixed: Color(0xff24005b),
      secondaryFixedDim: Color(0xffd1bcff),
      onSecondaryFixedVariant: Color(0xff533098),
      tertiaryFixed: Color(0xffffd7f0),
      onTertiaryFixed: Color(0xff3a0032),
      tertiaryFixedDim: Color(0xfffface7),
      onTertiaryFixedVariant: Color(0xff850075),
      surfaceDim: Color(0xffdfd7e7),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f1ff),
      surfaceContainer: Color(0xfff3ebfb),
      surfaceContainerHigh: Color(0xffede5f6),
      surfaceContainerHighest: Color(0xffe8dff0),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff44009e),
      surfaceTint: Color(0xff7413fd),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff761aff),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff421c87),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7a59c2),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff68005b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb1009d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff130f1a),
      onSurfaceVariant: Color(0xff393345),
      outline: Color(0xff564f63),
      outlineVariant: Color(0xff716a7e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332e3b),
      inversePrimary: Color(0xffd1bcff),
      primaryFixed: Color(0xff823dff),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6900eb),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7a59c2),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6140a7),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffc11fab),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff9d008b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcbc3d4),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f1ff),
      surfaceContainer: Color(0xffede5f6),
      surfaceContainerHigh: Color(0xffe2daea),
      surfaceContainerHighest: Color(0xffd6cfdf),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff380085),
      surfaceTint: Color(0xff7413fd),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5b00ce),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff370b7d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff55339b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff56004c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff890079),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2f293b),
      outlineVariant: Color(0xff4d4659),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332e3b),
      inversePrimary: Color(0xffd1bcff),
      primaryFixed: Color(0xff5b00ce),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff400095),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff55339b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3e1783),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff890079),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff620056),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbdb6c6),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6edfe),
      surfaceContainer: Color(0xffe8dff0),
      surfaceContainerHigh: Color(0xffd9d1e2),
      surfaceContainerHighest: Color(0xffcbc3d4),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd1bcff),
      surfaceTint: Color(0xffd1bcff),
      onPrimary: Color(0xff3d008f),
      primaryContainer: Color(0xff761aff),
      onPrimaryContainer: Color(0xffe4d5ff),
      secondary: Color(0xffd1bcff),
      onSecondary: Color(0xff3c1381),
      secondaryContainer: Color(0xff533098),
      onSecondaryContainer: Color(0xffc2a7ff),
      tertiary: Color(0xfffface7),
      onTertiary: Color(0xff5e0053),
      tertiaryContainer: Color(0xffb1009d),
      onTertiaryContainer: Color(0xffffceee),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff15121d),
      onSurface: Color(0xffe8dff0),
      onSurfaceVariant: Color(0xffccc2da),
      outline: Color(0xff958da3),
      outlineVariant: Color(0xff4a4457),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8dff0),
      inversePrimary: Color(0xff7413fd),
      primaryFixed: Color(0xffeaddff),
      onPrimaryFixed: Color(0xff24005b),
      primaryFixedDim: Color(0xffd1bcff),
      onPrimaryFixedVariant: Color(0xff5800c8),
      secondaryFixed: Color(0xffeaddff),
      onSecondaryFixed: Color(0xff24005b),
      secondaryFixedDim: Color(0xffd1bcff),
      onSecondaryFixedVariant: Color(0xff533098),
      tertiaryFixed: Color(0xffffd7f0),
      onTertiaryFixed: Color(0xff3a0032),
      tertiaryFixedDim: Color(0xfffface7),
      onTertiaryFixedVariant: Color(0xff850075),
      surfaceDim: Color(0xff15121d),
      surfaceBright: Color(0xff3c3744),
      surfaceContainerLowest: Color(0xff100c17),
      surfaceContainerLow: Color(0xff1d1a25),
      surfaceContainer: Color(0xff221e29),
      surfaceContainerHigh: Color(0xff2c2834),
      surfaceContainerHighest: Color(0xff37333f),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe4d6ff),
      surfaceTint: Color(0xffd1bcff),
      onPrimary: Color(0xff300074),
      primaryContainer: Color(0xffa277ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe4d6ff),
      onSecondary: Color(0xff300074),
      secondaryContainer: Color(0xff9f7ee9),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffceee),
      onTertiary: Color(0xff4b0042),
      tertiaryContainer: Color(0xffee4dd2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff15121d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe2d8f0),
      outline: Color(0xffb7aec5),
      outlineVariant: Color(0xff958da2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8dff0),
      inversePrimary: Color(0xff5900cb),
      primaryFixed: Color(0xffeaddff),
      onPrimaryFixed: Color(0xff170040),
      primaryFixedDim: Color(0xffd1bcff),
      onPrimaryFixedVariant: Color(0xff44009e),
      secondaryFixed: Color(0xffeaddff),
      onSecondaryFixed: Color(0xff170040),
      secondaryFixedDim: Color(0xffd1bcff),
      onSecondaryFixedVariant: Color(0xff421c87),
      tertiaryFixed: Color(0xffffd7f0),
      onTertiaryFixed: Color(0xff280022),
      tertiaryFixedDim: Color(0xfffface7),
      onTertiaryFixedVariant: Color(0xff68005b),
      surfaceDim: Color(0xff15121d),
      surfaceBright: Color(0xff47424f),
      surfaceContainerLowest: Color(0xff090610),
      surfaceContainerLow: Color(0xff1f1c27),
      surfaceContainer: Color(0xff2a2632),
      surfaceContainerHigh: Color(0xff35313d),
      surfaceContainerHighest: Color(0xff403c48),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff6ecff),
      surfaceTint: Color(0xffd1bcff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffceb7ff),
      onPrimaryContainer: Color(0xff100032),
      secondary: Color(0xfff6ecff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffceb7ff),
      onSecondaryContainer: Color(0xff100032),
      tertiary: Color(0xffffebf5),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffa6e6),
      onTertiaryContainer: Color(0xff1e0019),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff15121d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff6ecff),
      outlineVariant: Color(0xffc8bfd6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8dff0),
      inversePrimary: Color(0xff5900cb),
      primaryFixed: Color(0xffeaddff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffd1bcff),
      onPrimaryFixedVariant: Color(0xff170040),
      secondaryFixed: Color(0xffeaddff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd1bcff),
      onSecondaryFixedVariant: Color(0xff170040),
      tertiaryFixed: Color(0xffffd7f0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfffface7),
      onTertiaryFixedVariant: Color(0xff280022),
      surfaceDim: Color(0xff15121d),
      surfaceBright: Color(0xff534e5b),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff221e29),
      surfaceContainer: Color(0xff332e3b),
      surfaceContainerHigh: Color(0xff3e3946),
      surfaceContainerHighest: Color(0xff494552),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
