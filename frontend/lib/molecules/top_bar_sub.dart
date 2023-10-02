import 'package:flutter/material.dart';
import 'package:frontend/atom/button/alarm_button.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/util/auth_api.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/user.dart';

class TopBarSub extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  TopBarSub({required this.appBar});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();

    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
            onPressed: () {
                context.go('/scrapbook');

            },
            icon: Icon(Icons.bookmark_outline)
        ),
        IconButton(
            onPressed: () {
              context.go('/cart');
            },
            icon: Icon(Icons.interests_outlined)
        ),
        IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              if (user.accessToken.isNotEmpty) {
                context.push('/mypage');
              } else {
                context.push('/login');
              }
            },
            icon: Icon(Icons.person_outline)
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
