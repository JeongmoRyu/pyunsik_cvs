import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/molecules/appbar.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String emailValue = '';
  String keyValue = '';
  String keyValueCheck = '';
  String nickName = '';

  @override
  void initState() {
    super.initState();
    emailValue = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 150.0),
          child: ListView( // ListView로 감싸서 스크롤 가능하도록 수정
            padding: EdgeInsets.all(16.0),
            children: [
              Center(
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          emailValue = value;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintText: '이메일',
                        hintStyle: TextStyle(
                          fontSize: 14,
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        if (emailValue.isEmpty || !emailValue.contains('@')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a valid email address.'),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Confirmed'),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // 원하는 색상으로 변경
                      ),
                      child: Text('이메일 확인'),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          keyValue = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          hintText: '비밀번호',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          keyValueCheck = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          hintText: '비밀번호 확인',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          nickName = value;
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.adb,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          hintText: '닉네임',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        if (keyValue!.isEmpty || keyValue.length < 7) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a valid password'),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        } else if (keyValue != keyValueCheck) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('password and password confirm is not correct'),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Confirmed'),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // 원하는 색상으로 변경
                      ),
                      child: Text('회원가입'),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: Text('로그인으로 돌아가기'), // '회원가입' 텍스트 추가
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
