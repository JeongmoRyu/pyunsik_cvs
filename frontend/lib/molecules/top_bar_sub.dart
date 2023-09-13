import 'package:flutter/material.dart';
import 'package:frontend/atom/button/alarm_button.dart';

class TopBarSub extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  TopBarSub({required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_outline)
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.interests_outlined)
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
