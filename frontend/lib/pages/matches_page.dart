import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/pages/suggestion_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MatchesPage> {
  late User? user;

  Future<void> _handleSignOut(context) async {
    Navigator.of(context).pop();
    await Auth().signOut();
  }

  @override
  void initState() {
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
          'Matches',
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
      body: const Center(
        child: FutureBuilder(
            future: _fetchMatches(), builder: (context, snapshot) {}),
      ),
    );
  }

  void _handlepress(context) {
    Navigator.of(context).pop();
  }

  Future<List> _fetchMatches() async {
    /// Add fetch logic when backend is ready.
    /// temp solution to return hard coded data.
    var data = ['Liisa', 'Mikko', 'Marjaleena', 'Bile-Ismo'];

    return data;
  }
}
