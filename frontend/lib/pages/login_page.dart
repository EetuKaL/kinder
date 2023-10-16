import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String? errorMessage = '';
  bool isLogin = true;
  bool isFocusedToTextField = false;
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(1.5, 0),
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
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppbar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SlideTransition(
            position: _offsetAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                !isFocusedToTextField
                    ? Flexible(
                        child: Lottie.asset('assets/animation_login.json',
                            fit: BoxFit.contain,
                            frameRate: FrameRate(30),
                            reverse: true),
                      )
                    : Spacer(),
                Text(
                  isLogin ? 'Kirjaudu sisään' : 'Luo käyttäjä',
                  style: theme.textTheme.displayMedium,
                ),
                SizedBox(height: 16.0),
                Focus(
                  onFocusChange: (value) {
                    setState(() {
                      isFocusedToTextField = value;
                    });
                  },
                  child: TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Focus(
                  onFocusChange: (value) {
                    print(value);
                    setState(() {
                      isFocusedToTextField = value;
                    });
                  },
                  child: TextField(
                    controller: _controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    isLogin
                        ? signInWWithEmailAndPassword()
                        : createUserWithEmailAndPassword();
                    // Handle login here
                  },
                  child: Text(isLogin ? 'Login' : 'Register'),
                ),
                Flexible(
                  child: TextButton(
                      onPressed: () {
                        handleSwitch();
                      },
                      child: Text(isLogin
                          ? 'Create an account'
                          : 'Already have an account?')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
