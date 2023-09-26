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

  Future<dynamic>? _futureResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarSub(appBar: AppBar(),),// AppBar에 표시할 제목
      body: Center(
        child: (_futureResponse == null) ? buildForm() : buildFuture()
      ),
    );
  }

  Widget buildForm() {
    return Container(
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
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty
                    || value != _passwordController.text) {
                  return '비밀번호가 일치하지 않습니다.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '비밀번호 확인',
              ),
            ),
            SizedBox(height: 10,),
            FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _futureResponse = AuthApi.createUser(
                          _idController.text,
                          _passwordController.text
                      );
                    });
                  }
                },
                child: Text('회원가입')
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> buildFuture() {
    return FutureBuilder<dynamic>(
      future: _futureResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text('회원가입이 완료되었습니다.'),
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('로그인')
              )
            ],
          );
            //로그인 페이지로 이동
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('사용 중인 아이디입니다.'),
              TextButton(
                  onPressed: () {
                    context.push('/signup');
                  },
                  child: Text('회원가입')
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
