// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `An error occurred`
  String get error {
    return Intl.message('An error occurred', name: 'error', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Suggestion`
  String get suggestion {
    return Intl.message('Suggestion', name: 'suggestion', desc: '', args: []);
  }

  /// `No cards available`
  String get empty_cards {
    return Intl.message(
      'No cards available',
      name: 'empty_cards',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get create_account {
    return Intl.message(
      'Create an account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Already Have an Account?`
  String get already_have_account {
    return Intl.message(
      'Already Have an Account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `You are one step closer to finding your happiness :)`
  String get closer_to_happiness {
    return Intl.message(
      'You are one step closer to finding your happiness :)',
      name: 'closer_to_happiness',
      desc: '',
      args: [],
    );
  }

  /// `Kinder`
  String get app_name {
    return Intl.message('Kinder', name: 'app_name', desc: '', args: []);
  }

  /// `Go to matches page`
  String get go_to_matches {
    return Intl.message(
      'Go to matches page',
      name: 'go_to_matches',
      desc: '',
      args: [],
    );
  }

  /// `Image placeholder`
  String get image_placeholder {
    return Intl.message(
      'Image placeholder',
      name: 'image_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signout {
    return Intl.message('Sign out', name: 'signout', desc: '', args: []);
  }

  /// `Works at`
  String get works_at {
    return Intl.message('Works at', name: 'works_at', desc: '', args: []);
  }

  /// `Welcome to Kinder`
  String get welcome_to_kinder {
    return Intl.message(
      'Welcome to Kinder',
      name: 'welcome_to_kinder',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get error_general {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'error_general',
      desc: '',
      args: [],
    );
  }

  /// `The email address is badly formatted.`
  String get invalid_email {
    return Intl.message(
      'The email address is badly formatted.',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `The email address is already in use by another account.`
  String get email_in_use {
    return Intl.message(
      'The email address is already in use by another account.',
      name: 'email_in_use',
      desc: '',
      args: [],
    );
  }

  /// `The password must be at least 6 characters long.`
  String get weak_password {
    return Intl.message(
      'The password must be at least 6 characters long.',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `The email or password is incorrect.`
  String get user_or_password_incorrect {
    return Intl.message(
      'The email or password is incorrect.',
      name: 'user_or_password_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Liked`
  String get liked {
    return Intl.message('Liked', name: 'liked', desc: '', args: []);
  }

  /// `Disliked`
  String get disliked {
    return Intl.message('Disliked', name: 'disliked', desc: '', args: []);
  }

  /// `SuperLiked`
  String get superLiked {
    return Intl.message('SuperLiked', name: 'superLiked', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
