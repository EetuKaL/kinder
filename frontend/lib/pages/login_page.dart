import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/utils/auth.dart';
import 'package:frontend/utils/others.dart';
import 'package:frontend/utils/snackbar.dart';
import 'package:frontend/widgets/centered_circular_progress_indicator.dart';
import 'package:frontend/widgets/login_animation.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _login = true;

  bool isFocusedToTextField = false;
  bool isFocusedToTextField2 = false;
  late final AsyncHandler _asyncHandler;
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
  void initState() {
    super.initState();
    _asyncHandler = AsyncHandler(setState: setState);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void _toggleLoginRegister() async {
    await _animationController.forward();

    _controllerEmail.text = '';
    _controllerPassword.text = '';

    setState(() {
      _login = !_login;
    });
    await _animationController.reverse();
  }

  Future<void> _signInWithEmailAndPassword() async {
    _asyncHandler.tryCall<FirebaseAuthException>(
        context,
        () async => await Auth.of(context).signInWithEmailAndPassword(
            email: _controllerEmail.text,
            password: _controllerPassword.text), (e) {
      if (mounted) {
        switch (e.code) {
          case 'user-not-found':
            showErrorSnackBar(
                context, S.of(context).user_or_password_incorrect);
          case 'wrong-password':
            showErrorSnackBar(
                context, S.of(context).user_or_password_incorrect);
          case 'invalid-email':
            showErrorSnackBar(context, S.of(context).invalid_email);
          default:
            showErrorSnackBar(context, S.of(context).error_general);
        }
      }
    });
  }

  Future<void> _createUserWithEmailAndPassword() async {
    _asyncHandler.tryCall<FirebaseAuthException>(context, () async {
      final response = await Auth.of(context).createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      if (mounted) {
        await Auth.of(context).signInWithCredential(response.credential!);
      }
    }, (e) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;
    MediaQuery.of(context).viewInsets.bottom;
    final s = S.of(context);
    final rT = ResponsiveTheme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: rT.pageMargin,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                spacing: rT.spacingLoose,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (keyboardOpen)
                    const Flexible(child: LoginAnimation())
                  else
                    const Spacer(),
                  SizedBox(
                    height: rT.base * 8,
                    child: AnimatedSwitcher(
                        duration:
                            Duration(seconds: _asyncHandler.loading ? 2 : 1),
                        child: _asyncHandler.loading
                            ? const CenteredCircularProgressIndicator()
                            : Text(
                                key: ValueKey(_login),
                                _login ? s.login : s.create_account,
                                style: rT.display,
                              )),
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
                            if (_login) {
                              _signInWithEmailAndPassword();
                            } else {
                              _createUserWithEmailAndPassword();
                            }
                            return KeyEventResult.handled;
                          }
                          return KeyEventResult.ignored;
                        },
                        canRequestFocus: true),
                    controller: _controllerPassword,
                    obscureText: true,
                    onSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(),
                    decoration: InputDecoration(hintText: s.password),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _login
                          ? _signInWithEmailAndPassword()
                          : _createUserWithEmailAndPassword();
                    },
                    child: Text(_login ? s.login : s.create_account),
                  ),
                  TextButton(
                      onPressed: () {
                        _toggleLoginRegister();
                      },
                      child: Text(
                          _login ? s.create_account : s.already_have_account)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
