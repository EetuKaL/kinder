import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/utils/auth.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // user = Auth().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          s.profile,
          style: theme.textTheme.displayLarge,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: IconButton(
              icon: const Image(
                image: AssetImage('assets/arrow-back.png'),
              ),
              onPressed: () {}),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '${''}',
              style: theme.textTheme.displayMedium,
            ),
            Container(
              height: 200,
              color: Colors.blueAccent,
              child: Text(s.image_placeholder),
            ),
            ElevatedButton(
                onPressed: () async => await _logout(context),
                child: Text(s.signout))
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await Auth.of(context).signOut();
  }
}
