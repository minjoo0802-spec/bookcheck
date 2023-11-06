import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.menu,
      //     color: Colors.black,
      //   ),
      //   onPressed: () {
      //     // Navigator.of(context).pop();
      //   },
      // ),
      title: Image.asset(
        'assets/images/app_bar_icon/logo.png',
        width: 55,
        height: 55,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Image.asset(
        'assets/images/app_bar_icon/logo.png',
        width: 55,
        height: 55,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
