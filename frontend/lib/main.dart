import 'package:flutter/material.dart';
import 'package:frontend/pages/kinder_card.dart';
import 'package:frontend/pages/suggestion_page.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SuggestionPage()),
    );
  }
}
