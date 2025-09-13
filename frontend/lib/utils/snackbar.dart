import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

_showSnackBar(
        BuildContext context, String message, Color color, Color onColor) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: ResponsiveTheme.of(context).body.copyWith(color: onColor),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    ));

void showErrorSnackBar(BuildContext context, String message) {
  _showSnackBar(
    context,
    message,
    Theme.of(context).colorScheme.error,
    Theme.of(context).colorScheme.onError,
  );
}
