import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/theme/theme_schemes.dart';
import 'package:frontend/theme/theme_util.dart';

class MaterialThemeBuilder extends StatefulWidget {
  final Function(BuildContext, ThemeData) builder;

  const MaterialThemeBuilder({Key? key, required this.builder})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MaterialThemeBuilderState createState() => _MaterialThemeBuilderState();
}

class _MaterialThemeBuilderState extends State<MaterialThemeBuilder> {
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme =
        createTextTheme(context, "Noto Sans Adlam", "ADLaM Display");

    final colorScheme =
        brightness == Brightness.dark ? darkScheme() : lightScheme();

    ResponsiveThemeData responsiveThemeData =
        ResponsiveThemeData(context, textTheme, colorScheme: colorScheme);

    return ResponsiveTheme(
      data: responsiveThemeData,
      child: widget.builder(context, responsiveThemeData.constructThemeData()),
    );
  }
}
