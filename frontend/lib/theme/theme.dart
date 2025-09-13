import "package:flutter/material.dart";
import "package:frontend/theme/theme_definitions.dart";
import "package:frontend/theme/theme_util.dart";

const _base = 8.0;

class ResponsiveThemeData {
  late final TextTheme textTheme;
  late final ScreenType screenType;
  final ColorScheme colorScheme;

  ResponsiveThemeData(BuildContext context, TextTheme theme,
      {required this.colorScheme}) {
    screenType = getScreenType(MediaQuery.sizeOf(context).width);
    textTheme = theme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );
  }

  TextStyle get label => valueByScreenType(
      textTheme.labelSmall!, textTheme.labelMedium!, textTheme.labelLarge!);

  TextStyle get body => valueByScreenType(
      textTheme.bodySmall!, textTheme.bodyMedium!, textTheme.bodyLarge!);

  TextStyle get title => valueByScreenType(
      textTheme.titleSmall!, textTheme.titleMedium!, textTheme.titleLarge!);

  TextStyle get headline => valueByScreenType(textTheme.headlineSmall!,
      textTheme.headlineMedium!, textTheme.headlineLarge!);

  TextStyle get display => valueByScreenType(textTheme.displaySmall!,
      textTheme.displayMedium!, textTheme.displayLarge!);

  static double getResponsiveWidth(BuildContext context, double width) {
    return width * MediaQuery.of(context).size.width / 375;
  }

  double get base => valueByScreenTypeScaled<double>(_base, 0.25);

  double get spacingTight => valueByScreenTypeScaled<double>(_base * 0.5, 0.25);
  double get spacing => valueByScreenTypeScaled<double>(_base, 0.25);
  double get spacingLoose => valueByScreenTypeScaled<double>(_base * 2, 0.25);
  double get spacingExtraLoose =>
      valueByScreenTypeScaled<double>(_base * 4, 0.25);

  EdgeInsets get paddingTight =>
      EdgeInsets.all(valueByScreenTypeScaled<double>(_base * 0.5, 0.25));
  EdgeInsets get padding =>
      EdgeInsets.all(valueByScreenTypeScaled<double>(_base, 0.25));
  EdgeInsets get paddingLoose =>
      EdgeInsets.all(valueByScreenTypeScaled<double>(_base * 2, 0.25));
  EdgeInsets get paddingExtraLoose =>
      EdgeInsets.all(valueByScreenTypeScaled<double>(_base * 4, 0.25));

  Size get iconSize => Size(valueByScreenTypeScaled<double>(_base * 4, 0.25),
      valueByScreenTypeScaled<double>(_base * 4, 0.25));

  double get borderRadius => valueByScreenTypeScaled<double>(_base * 4, 0.25);

  EdgeInsets get pageMargin =>
      EdgeInsets.all(valueByScreenType(_base * 2, _base * 3, _base * 3));

  ThemeData constructThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }
}

class ResponsiveTheme extends InheritedWidget {
  final ResponsiveThemeData data;

  const ResponsiveTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static ResponsiveThemeData of(BuildContext context) {
    final ResponsiveTheme? result =
        context.dependOnInheritedWidgetOfExactType<ResponsiveTheme>();
    assert(result != null, 'No MaterialTheme found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(ResponsiveTheme oldWidget) =>
      data.screenType != oldWidget.data.screenType ||
      data.textTheme != oldWidget.data.textTheme;
}
