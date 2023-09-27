import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/user.dart';

import '../util/auth_api.dart';

class MyPage extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return Scaffold(
      appBar: TopBarSub(appBar: AppBar()),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: '${user.nickname}',
                  hintText: user.nickname,
                ),
              ),
              SizedBox(height: 10),
              // TextFormField(
              //   controller: _passwordController,
              //   obscureText: true, // 비밀번호는 가려진 형태로 입력
              //   decoration: InputDecoration(
              //     labelText: '비밀번호',
              //     hintText: user._password,
              //   ),
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
