import 'package:flutter/material.dart';
import 'package:kinderfrontend/generated/l10n.dart';
import 'package:kinderfrontend/models/auth.dart';
import 'package:kinderfrontend/widgets/custom_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String? errorMessage = '';
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

  Future<void> signInWWithEmailAndPassword() async {
    context.read<Auth>().mockLogin();
    /*  try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    } */
  }

  Future<void> createUserWithEmailAndPassword() async {
    /*  try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.message}'))r);
    } */
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;
    MediaQuery.of(context).viewInsets.bottom;
    final theme = Theme.of(context);
    final s = S.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SlideTransition(
            position: _offsetAnimation,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                spacing: 16.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (keyboardOpen)
                    Flexible(
                      child: Lottie.asset('assets/animation_login.json',
                          fit: BoxFit.contain,
                          frameRate: FrameRate(30),
                          reverse: true),
                    )
                  else
                    const Spacer(),
                  Text(
                    isLogin ? s.login : s.create_account,
                    style: theme.textTheme.displayMedium,
                  ),
                  TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(hintText: s.email),
                    onSubmitted: (value) => FocusScope.of(context).nextFocus(),
                  ),
                  TextField(
                    controller: _controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(hintText: s.password),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      isLogin
                          ? signInWWithEmailAndPassword()
                          : createUserWithEmailAndPassword();
                    },
                    child: Text(isLogin ? s.login : s.create_account),
                  ),
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
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
