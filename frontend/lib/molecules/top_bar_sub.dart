import 'package:flutter/material.dart';
import 'package:frontend/atom/button/alarm_button.dart';
import 'package:go_router/go_router.dart';

class TopBarSub extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  TopBarSub({required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
            onPressed: () {
              context.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)
        ),
        IconButton(
            onPressed: () {
              context.go('/scrapbook');
            },
            icon: Icon(Icons.bookmark_outline)
        ),
        IconButton(
            onPressed: () {
              context.go('/cart_page');
            },
            icon: Icon(Icons.interests_outlined)
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
