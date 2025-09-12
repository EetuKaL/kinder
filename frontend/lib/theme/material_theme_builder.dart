import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/theme/theme_util.dart';

class MaterialThemeBuilder extends StatefulWidget {
  final Function(BuildContext, MaterialTheme) builder;

  const MaterialThemeBuilder({Key? key, required this.builder})
      : super(key: key);

  @override
  _MaterialThemeBuilderState createState() => _MaterialThemeBuilderState();
}

class _MaterialThemeBuilderState extends State<MaterialThemeBuilder> {
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme =
        createTextTheme(context, "Noto Sans Adlam", "ADLaM Display");

      MaterialThemeData themeData = MaterialThemeData(context, textTheme: textTheme);

      themeData = theme.Light
        brightness == Brightness.light ? theme.light() : theme.dark()

    return Container(
      child: widget.builder(context, MaterialTheme.of(context)),
    );
  }
}
