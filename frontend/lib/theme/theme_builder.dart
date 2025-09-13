import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/theme/theme_schemes.dart';
import 'package:frontend/theme/theme_util.dart';

class ResponsiveThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme) builder;

  const ResponsiveThemeBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final colorScheme =
        brightness == Brightness.dark ? darkScheme() : lightScheme();
    TextTheme textTheme =
        createTextTheme(context, "Noto Sans Adlam", "ADLaM Display");

    final theme =
        ResponsiveThemeData(context, textTheme, colorScheme: colorScheme);
    return ResponsiveTheme(
      data: theme,
      child: builder(context, theme.constructThemeData()),
    );
  }
}
