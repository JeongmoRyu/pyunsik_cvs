import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:provider/provider.dart';

import '../util/auth_api.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loginFailed = false;

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    return Scaffold(
      appBar: TopBarSub(appBar: AppBar(),),// AppBar에 표시할 제목
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _idController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '아이디를 입력해주세요.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '아이디',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                  ),
                ),
                SizedBox(height: 10,),
                FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthApi.login(
                            _idController.text,
                            _passwordController.text
                        ).then((userModel) {
                          user.setFromUserModel(userModel);
                          context.go('/');
                        }).onError((error, stackTrace) {
                          setState(() {
                            loginFailed = true;
                            print('아이디 또는 비밀번호가 잘못되었습니다.');
                          });
                        });
                      }
                    },
                    child: Text('로그인')
                ),
                TextButton(
                  onPressed: () {
                    context.push('/signup');
                  },
                  child: Text('회원가입')
                ),
              ],
            ),
          ),
        ),
      )
    );//'아이디 또는 비밀번호가 잘못되었습니다.'
  }
}
