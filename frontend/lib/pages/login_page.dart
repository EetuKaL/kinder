import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/utils/auth.dart';
import 'package:frontend/utils/kinder_responsiveness.dart';
import 'package:frontend/utils/snackbar.dart';
import 'package:frontend/widgets/login_animation.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool isFocusedToTextField = false;
  bool isFocusedToTextField2 = false;
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(5, 0),
  ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticIn));

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void handleSwitch() async {
    await _animationController.forward();

    setState(() {
      isLogin = !isLogin;
    });
    _controllerEmail.text = '';
    _controllerPassword.text = '';

    await _animationController.reverse();
  }

  Future<void> _signInWWithEmailAndPassword() async {
    try {
      await Auth.of(context).signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        switch (e.code) {
          case 'user-not-found':
            showErrorSnackBar(
                context, S.of(context).user_or_password_incorrect);
          case 'wrong-password':
            showErrorSnackBar(
                context, S.of(context).user_or_password_incorrect);
          default:
            showErrorSnackBar(context, S.of(context).error_general);
        }
      }
    }
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      final response = await Auth.of(context).createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      if (mounted) {
        await Auth.of(context).signInWithCredential(response.credential!);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        switch (e.code) {
          case 'weak-password':
            showErrorSnackBar(context, S.of(context).weak_password);
          case 'email-already-in-use':
            showErrorSnackBar(context, S.of(context).email_in_use);
          case 'invalid-email':
            showErrorSnackBar(context, S.of(context).invalid_email);
          default:
            showErrorSnackBar(context, S.of(context).error_general);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;
    MediaQuery.of(context).viewInsets.bottom;
    final s = S.of(context);
    final responsive = KinderResponsiveness.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: responsive.pageMargin,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                spacing: responsive.spacingLoose,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (keyboardOpen)
                    const Flexible(child: LoginAnimation())
                  else
                    const Spacer(),
                  Text(
                    isLogin ? s.login : s.create_account,
                    style: responsive.textStyle.display,
                  ),
                  TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(hintText: s.email),
                    onSubmitted: (value) => FocusScope.of(context).nextFocus(),
                  ),
                  TextField(
                    focusNode: FocusNode(
                        onKeyEvent: (node, event) {
                          if (event.logicalKey == LogicalKeyboardKey.enter ||
                              event.physicalKey == PhysicalKeyboardKey.enter) {
                            _signInWWithEmailAndPassword();
                            return KeyEventResult.handled;
                          }
                          return KeyEventResult.ignored;
                        },
                        canRequestFocus: true),
                    controller: _controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(hintText: s.password),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isLogin
                          ? _signInWWithEmailAndPassword()
                          : _createUserWithEmailAndPassword();
                    },
                    child: Text(isLogin ? s.login : s.create_account),
                  ),
                  TextButton(
                      onPressed: () {
                        handleSwitch();
                      },
                      child: Text(
                          isLogin ? s.create_account : s.already_have_account)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
