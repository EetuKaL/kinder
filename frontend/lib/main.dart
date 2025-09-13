import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/suggestion_page.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/theme/theme_builder.dart';
import 'package:frontend/utils/auth.dart';
import 'package:frontend/widgets/auth_redirector.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    Auth(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CardProvider()),
        ],
        child: const MyApp(),
      ),
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
    return ResponsiveThemeBuilder(builder: (context, theme) {
      return AuthRedirector(
        builder: (navigatorKey) => MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: const [S.delegate],
          locale: const Locale('en'),
          title: 'Kinder',
          theme: theme,
          initialRoute: Auth.of(context).currentUser != null
              ? SuggestionPage.routeName
              : LoginPage.routeName,
          routes: {
            LoginPage.routeName: (context) => const LoginPage(),
            SuggestionPage.routeName: (context) => const SuggestionPage(),
            ProfilePage.routeName: (context) => const ProfilePage(),
          },
        ),
      );
    });
  }
}
