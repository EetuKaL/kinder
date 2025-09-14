import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/pages/profile_page.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: IconButton(
            icon: const Image(
              image: AssetImage('assets/profile_img.png'),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ProfilePage.routeName);
            }),
      ),
      // Title
      centerTitle: true,
      title: Text('Kinder',
          textAlign: TextAlign.center, style: theme.textTheme.displayLarge),
      actions: <Widget>[
        // Matches Button
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: IconButton(
            icon: const Image(image: AssetImage('assets/chat_img.png')),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).go_to_matches)));
            },
          ),
        ),
      ],
    );
  }
}
