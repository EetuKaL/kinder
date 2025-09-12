import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/suggestion_page.dart';
import 'package:frontend/utils/auth.dart';

class AuthRedirector extends StatefulWidget {
  final Widget Function(GlobalKey<NavigatorState>) builder;
  const AuthRedirector({super.key, required this.builder});

  @override
  State<AuthRedirector> createState() => _AuthRedirectorState();
}

class _AuthRedirectorState extends State<AuthRedirector> {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth.of(context).authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (ModalRoute.of(context)?.settings.name !=
                SuggestionPage.routeName) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  _key.currentState
                      ?.pushReplacementNamed(SuggestionPage.routeName);
                },
              );
            }
          } else {
            if (ModalRoute.of(context)?.settings.name != LoginPage.routeName) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  _key.currentState?.pushReplacementNamed(LoginPage.routeName);
                },
              );
            }
          }
          return widget.builder(_key);
        });
  }
}
