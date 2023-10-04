import 'package:flutter/material.dart';
import 'package:frontend/atom/button/alarm_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/user.dart';

import '../util/constants.dart';

class TopBarMain extends StatelessWidget implements PreferredSizeWidget {

  final AppBar appBar;
  TopBarMain({required this.appBar});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      actions: <Widget>[
        SizedBox(width: 10,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
               context.push('/search');
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(241, 241, 241, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search, color: Constants.lightGrey),
                    ),
                    Text('편식 통합검색', style: TextStyle(
                        color: Constants.lightGrey
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        ),
        IconButton( //아이콘들 오른쪽으로 붙히고 싶다.
            padding: EdgeInsets.all(0),
            onPressed: () {
                context.go('/scrapbook');
            },
            icon: Icon(Icons.bookmark_outline)
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
        // Visibility(
        //   visible: user.accessToken != '',
        //     child: AlarmButton()),

        SizedBox(width: 10,),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
