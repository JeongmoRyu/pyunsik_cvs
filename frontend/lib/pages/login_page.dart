import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import  'package:provider/provider.dart';

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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    return Scaffold(
      appBar: TopBarSub(appBar: AppBar(),),// AppBar에 표시할 제목
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('로그인', style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  SizedBox(height: 20,),
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
                    obscureText: true,
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
                        if (isLoading) {
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          AuthApi.login(
                              _idController.text,
                              _passwordController.text
                          ).then((userModel) {
                            user.setFromUserModel(userModel);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('로그인에 성공했습니다.'),
                                duration: Duration(milliseconds: 1500),
                              ),
                            );
                            print('login successful with token ${user.accessToken}');
                            context.go('/');
                          }).onError((error, stackTrace) {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('아이디 또는 비밀번호가 잘못되었습니다.'),
                                duration: Duration(milliseconds: 1500),
                              ),
                            );
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
                  SizedBox(height: 10,),
                  Visibility( //나중에 dialog로 바꾸고 싶다.
                    visible: isLoading,
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text('로그인 중...'),
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );//'아이디 또는 비밀번호가 잘못되었습니다.'
  }
}
