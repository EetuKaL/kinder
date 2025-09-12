import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _base = 8.0;

class KinderResponsiveness extends InheritedWidget {
  late final ResponsiveTextStyle textStyle;
  late final ScreenType screenType;
  KinderResponsiveness(BuildContext context,
      {super.key, required super.child}) {
    screenType = _getScreenType(MediaQuery.sizeOf(context).width);
    textStyle = _valueByScreenType<ResponsiveTextStyle>(
      ResponsiveTextStyle.small(Theme.of(context).textTheme),
      ResponsiveTextStyle.medium(Theme.of(context).textTheme),
      ResponsiveTextStyle.large(Theme.of(context).textTheme),
    );
  }
  static double getResponsiveWidth(BuildContext context, double width) {
    return width * MediaQuery.of(context).size.width / 375;
  }

  double get base => _valueByScreenTypeScaled<double>(_base, 0.25);

  double get spacingTight =>
      _valueByScreenTypeScaled<double>(_base * 0.5, 0.25);
  double get spacing => _valueByScreenTypeScaled<double>(_base, 0.25);
  double get spacingLoose => _valueByScreenTypeScaled<double>(_base * 2, 0.25);
  double get spacingExtraLoose =>
      _valueByScreenTypeScaled<double>(_base * 4, 0.25);

  EdgeInsets get paddingTight =>
      EdgeInsets.all(_valueByScreenTypeScaled<double>(_base * 0.5, 0.25));
  EdgeInsets get padding =>
      EdgeInsets.all(_valueByScreenTypeScaled<double>(_base, 0.25));
  EdgeInsets get paddingLoose =>
      EdgeInsets.all(_valueByScreenTypeScaled<double>(_base * 2, 0.25));
  EdgeInsets get paddingExtraLoose =>
      EdgeInsets.all(_valueByScreenTypeScaled<double>(_base * 4, 0.25));

  Size get iconSize => Size(_valueByScreenTypeScaled<double>(_base * 4, 0.25),
      _valueByScreenTypeScaled<double>(_base * 4, 0.25));

  double get borderRadius => _valueByScreenTypeScaled<double>(_base * 4, 0.25);

  EdgeInsets get pageMargin =>
      EdgeInsets.all(_valueByScreenType(_base * 2, _base * 3, _base * 3));

  T _valueByScreenTypeScaled<T>(T value, double factor) {
    try {
      final val = value as dynamic;
      return _valueByScreenType<T>(
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

  T _valueByScreenType<T>(
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

  static double getResponsiveHeight(BuildContext context, double height) {
    return height * MediaQuery.of(context).size.height / 812;
  }

  @override
  bool updateShouldNotify(covariant KinderResponsiveness oldWidget) {
    return textStyle != oldWidget.textStyle ||
        screenType != oldWidget.screenType;
  }

  static KinderResponsiveness of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<KinderResponsiveness>()!;
  }
}

enum ScreenType { compact, medium, expanded, large, extralarge }

_getScreenType(double width) {
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

class ResponsiveTextStyle {
  final TextStyle label;
  final TextStyle body;
  final TextStyle title;
  final TextStyle headline;
  final TextStyle display;
  ResponsiveTextStyle._(
      {required this.label,
      required this.body,
      required this.title,
      required this.headline,
      required this.display});

  static ResponsiveTextStyle small(TextTheme t) => ResponsiveTextStyle._(
        label: t.labelSmall!,
        body: t.bodySmall!,
        title: t.titleSmall!,
        headline: t.headlineSmall!,
        display: t.displaySmall!,
      );
  static ResponsiveTextStyle medium(TextTheme t) => ResponsiveTextStyle._(
        label: t.labelMedium!,
        body: t.bodyMedium!,
        title: t.titleMedium!,
        headline: t.headlineMedium!,
        display: t.displayMedium!,
      );
  static ResponsiveTextStyle large(TextTheme t) => ResponsiveTextStyle._(
        label: t.labelLarge!,
        body: t.bodyLarge!,
        title: t.titleLarge!,
        headline: t.headlineLarge!,
        display: t.displayLarge!,
      );
}
