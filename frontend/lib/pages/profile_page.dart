import 'package:flutter/material.dart';
import 'package:kinderfrontend/generated/l10n.dart';
import 'package:kinderfrontend/models/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _handleSignOut(context) async {
    Navigator.of(context).pop();
    /*  await Auth().signOut(); */
    context.read<Auth>().mockLogout();
  }

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
              onPressed: () {
                _handlepress(context);
              }),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Expanded(
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
                onPressed: () {
                  _handleSignOut(context);
                },
                child: Text(s.signout))
          ],
        )),
      ),
    );
  }

  void _handlepress(context) {
    Navigator.of(context).pop();
  }
}
