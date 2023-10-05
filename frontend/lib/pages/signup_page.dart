import 'package:flutter/material.dart';
import 'package:frontend/util/auth_api.dart';
import 'package:frontend/molecules/top_bar_sub.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarSub(appBar: AppBar(),),// AppBar에 표시할 제목
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('회원가입', style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _idController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '아이디를 입력해주세요';
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
                        return '비밀번호를 입력해주세요';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '비밀번호',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty
                          || value != _passwordController.text) {
                        return '비밀번호가 일치하지 않습니다';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '비밀번호 확인',
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
                          AuthApi.createUser(
                              _idController.text,
                              _passwordController.text
                          ).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('회원가입이 완료되었습니다'),
                                duration: Duration(milliseconds: 1500),
                              ),
                            );
                            context.pop();
                          }).onError((error, stackTrace) {
                            print(error);
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('사용 중인 아이디입니다'),
                                duration: Duration(milliseconds: 1500),
                              ),
                            );
                          });
                        }
                      },
                      child: Text('회원가입')
                  ),
                  SizedBox(height: 10,),
                  Visibility(
                      visible: isLoading,
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10,),
                          Text('회원가입 중...'),
                        ],
                      )
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
