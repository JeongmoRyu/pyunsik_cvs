import 'package:flutter/material.dart';
import 'package:frontend/molecules/appbar.dart';
import 'package:frontend/molecules/horizontal_list.dart';

class SideScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),// AppBar에 표시할 제목
        body: Container(
          height: 250, // 원하는 높이로 설정
          // child: HorizontalList(),
        ),
      ),
    );
  }
}
