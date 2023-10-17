import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/pages/suggestion_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user;

  Future<void> _handleSignOut(context) async {
    Navigator.of(context).pop();
    await Auth().signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Auth().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Profile',
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
              '${user?.email}',
              style: theme.textTheme.displayMedium,
            ),
            Container(
              height: 200,
              color: Colors.blueAccent,
              child: Text('image placeholder'),
            ),
            ElevatedButton(
                onPressed: () {
                  _handleSignOut(context);
                },
                child: Text('signout'))
          ],
        )),
      ),
    );
  }

  void _handlepress(context) {
    Navigator.of(context).pop();
  }
}
