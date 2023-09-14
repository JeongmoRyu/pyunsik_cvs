import 'package:flutter/material.dart';
import 'package:frontend/atom/button/alarm_button.dart';
import 'package:go_router/go_router.dart';

class TopBarMain extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  TopBarMain({required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(241, 241, 241, 1.0),
                  prefixIcon: Icon(Icons.search,),
                  border: InputBorder.none
              ),
            ),
          ),
        ),
        // action : [
        //
        // ],
        IconButton(
            onPressed: () {
              context.go('/scrapbook');
            },
            icon: Icon(Icons.bookmark_outline)
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.interests_outlined)
        ),
        AlarmButton(),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
