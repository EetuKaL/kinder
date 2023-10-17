import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/theme.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/suggestion_page.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider<CardProvider>(
    create: (_) => CardProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kinder',
        theme: kindertheme,
        home: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SuggestionPage();
            } else {
              return LoginPage();
            }
          },
        ));
  }
}
