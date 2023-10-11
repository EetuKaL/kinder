import 'package:flutter/material.dart';

final ThemeData kindertheme = _kinderTheme();

const Color primary = Color(0xFF4E4B6F);
const Color black = Color(0xFF0F0C0C);
const Color white = Color.fromARGB(255, 235, 232, 232);
const appBarBackground = Color.fromARGB(255, 97, 95, 117);

const double titleSize = 40;
const double bigParagraphs = 24;
const double paragraphs = 16;

ThemeData _kinderTheme() {
  // Base theme
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      primaryColor: primary,
      colorScheme: base.colorScheme.copyWith(
          primary: primary,
          onPrimary: const Color.fromARGB(255, 45, 44, 65),
          secondary: black,
          onSecondary: const Color.fromARGB(255, 204, 203, 203),
          surface: const Color(0xA0D9D9D9),
          background: white),
      textTheme: _kinderTextTheme(base.textTheme));
}

TextTheme _kinderTextTheme(TextTheme base) => base.copyWith(

    // Appbar title and headlines
    displayLarge: base.displayLarge!.copyWith(
        fontSize: titleSize,
        fontFamily: 'Montagu Slab',
        fontWeight: FontWeight.w700,
        height: 0,
        letterSpacing: -0.48,
        color: primary),
    // Bigger paragraphs / contents
    displayMedium: base.displayMedium!.copyWith(
        fontSize: bigParagraphs,
        fontFamily: 'Montagu Slab',
        fontWeight: FontWeight.w700,
        height: 0,
        letterSpacing: -0.48,
        color: primary),
    // Normal paragraphs / contents
    displaySmall: base.displaySmall!.copyWith(
        fontSize: paragraphs,
        fontFamily: 'Montagu Slab',
        fontWeight: FontWeight.w700,
        height: 0,
        letterSpacing: -0.48,
        color: black));
