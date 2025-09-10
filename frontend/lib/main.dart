import 'package:flutter/material.dart';
import 'package:kinderfrontend/generated/l10n.dart';
import 'package:kinderfrontend/theme/theme.dart';
import 'package:kinderfrontend/theme/util.dart';
import 'package:kinderfrontend/models/auth.dart';
import 'package:kinderfrontend/pages/login_page.dart';
import 'package:kinderfrontend/pages/suggestion_page.dart';
import 'package:kinderfrontend/provider/card_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardProvider()),
        Provider(create: (_) => Auth()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Use with Google Fonts package to use downloadable fonts
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme =
        createTextTheme(context, "Noto Sans Adlam", "ADLaM Display");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      localizationsDelegates: const [S.delegate],
      locale: const Locale('en'),
      title: 'Kinder',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: StreamBuilder(
        stream: context.read<Auth>().authStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const SuggestionPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
