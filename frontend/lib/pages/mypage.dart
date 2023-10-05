import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/user.dart';

class MyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    String? token;
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    });
    return Scaffold(
      appBar: TopBarSub(appBar: AppBar()),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text('마이페이지', style: TextStyle(
                    fontSize: 25
                  ),
                ),
                SizedBox(height: 50,),
                Text('아이디: ${user.nickname}'),

                TextFormField(initialValue: token),
                SizedBox(height: 100,),
                FilledButton(
                    onPressed: () {
                      user.logout();
                      context.go('/');
                    },
                    child: Text('로그아웃')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
