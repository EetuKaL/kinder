import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  // fix later+
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: IconButton(
          icon: const Image(
            image: AssetImage('assets/profile_img.png'),
          ),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Go to profile page')));
          },
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Kinder',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF4E4B6F),
          fontSize: 24,
          fontFamily: 'Montagu Slab',
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          height: 0,
          letterSpacing: -0.48,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: IconButton(
            icon: const Image(image: AssetImage('assets/chat_img.png')),
            tooltip: 'Go to the next page',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Go to matches page')));
            },
          ),
        ),
      ],
    );
  }
}  // TODO: implement preferredSize

