import 'package:flutter/material.dart';
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
      // Profile Button
      leading: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: IconButton(
            icon: const Image(
              image: AssetImage('assets/profile_img.png'),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
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
                  const SnackBar(content: Text('Go to matches page')));
            },
          ),
        ),
      ],
    );
  }
}
