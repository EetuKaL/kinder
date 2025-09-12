import "package:flutter/material.dart";
import "package:frontend/theme/theme_definitions.dart";
import "package:frontend/theme/theme_util.dart";

const _base = 8.0;

class MaterialThemeData extends ThemeData {
  final TextTheme textTheme;
  late final ScreenType screenType;

  MaterialThemeData(BuildContext context, {required this.textTheme}) {
    screenType = getScreenType(MediaQuery.sizeOf(context).width);
  }

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

  static ThemeData constructThemeData(
          TextTheme textTheme, ColorScheme colorScheme) =>
      ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );
}

class MaterialTheme extends InheritedWidget {
  final MaterialThemeData data;

  const MaterialTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static MaterialThemeData of(BuildContext context) {
    final MaterialTheme? result =
        context.dependOnInheritedWidgetOfExactType<MaterialTheme>();
    assert(result != null, 'No MaterialTheme found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(MaterialTheme oldWidget) =>
      data.screenType != oldWidget.data.screenType ||
      data.textTheme != oldWidget.data.textTheme;
}
