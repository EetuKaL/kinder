import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

export 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

class Auth extends InheritedWidget {
  final FirebaseAuth fb = FirebaseAuth.instance;

  Auth({Key? key, required Widget child}) : super(key: key, child: child);

  static FirebaseAuth? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Auth>()?.fb;
  }

  static FirebaseAuth of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Auth>()!.fb;
  }

  @override
  bool updateShouldNotify(Auth oldWidget) {
    return oldWidget.fb != fb;
  }
}
